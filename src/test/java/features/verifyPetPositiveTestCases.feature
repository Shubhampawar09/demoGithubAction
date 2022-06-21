Feature: Add pet to store

  Background:
    * print 'hello'
    * def random =
    """
    function randomString(length) {
    var result           = '';
    var characters       = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
    var charactersLength = characters.length;
    for ( var i = 0; i < length; i++ ) {
       result += characters.charAt(Math.floor(Math.random() * charactersLength));
    }
    return result;
 }
    """
    * def random_Integer =
    """
    function ranInteger(x) {
    if (x) {
        return new java.util.Random().nextInt(Math.pow(10, x));
    } else {
        return new java.util.Random().nextInt(100000000);
    }
}
    """

#    * def jsUtils = read('../utils/jsUtils.js')
    * def randomInt = ranInteger(3)

    * def randomstr = randomString(5)
    * print 'world'
    * print randomstr
    * def requestBody =
  """
{
   "id":'#(randomInt)',
   "category":{
      "id":0,
      "name":""
   },
   "name":'#(randomstr)',
   "photoUrls":[
      "string"
   ],
   "tags":[
      {
         "id":0,
         "name":"string"
      }
   ],
   "status":'#(randomstr)'
}
  """

  @regression @createAndDeleteById
  Scenario: create pet details and delete pet details using id

    Given url baseurl
    And request requestBody
    When method POST
    Then status 200
    * print response
    * def respId = response.id
    * print respId

    Given url baseurl
    And path respId
#    And form fields query
    When method DELETE
    * print response
    * def resp = response.code
    * def respmessage = response.message
    * match resp contains response.code
    * match respmessage contains response.message
    Then status 200

  @regression @createAndGetDetailsByStatus
  Scenario: create pet details and get pet details using id and status

    Given url baseurl
    And request requestBody
    When method POST
    Then status 200
    * print response
    * def respId = response.id
    * print respId

    Given url baseurl
    And path respId
    When method GET
    Then status 200
    * print response
    * def respStatus = response.status
    * match respStatus == response.status

  @regression @createAndUpdate
  Scenario Outline: create pet details and update pet details

    * def randomString =
    """
    function randomString(length) {
    var result           = '';
    var characters       = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
    var charactersLength = characters.length;
    for ( var i = 0; i < length; i++ ) {
       result += characters.charAt(Math.floor(Math.random() * charactersLength));
    }
    return result;
 }

    """
    * def randomstr = randomString(5)

    * def requestUpdate =
  """
{
   "id":'#(randomInt)',
   "category":{
      "id":0,
      "name":'<categoryname>'
   },
   "name":"#(randomstr)",
   "photoUrls":[
      "string"
   ],
   "tags":[
      {
         "id":0,
         "name":'<tag>'
      }
   ],
   "status":'<status>'
}
  """

    Given url baseurl
    And request requestUpdate
    When method POST
    Then status 200
    * print response
    * def respId = response.id
    * print respId

    Given url baseurl
#    And form fields query
    And request requestUpdate
    When method PUT
    * print response
    * def respName = response.name
    * def respStatus = response.status
    * match respName == response.name
    * match respStatus == response.status
    Then status <actualstatus>
    Examples:
      |status       |categoryname  |actualstatus      |tag           |
      |unavailable  |german        |200               |bruno         |
      |pending      |husky         |200               |leo           |


  @regression @CreateAndUpdateById
  Scenario Outline: update pet details by id

    Given url baseurl
    And request requestBody
    When method POST
    Then status 200
    * print response
    * def respId = response.id
    * print respId

    * def query = {name : '<name>' , status : '<status>'}
    Given url baseurl
    And path respId
    And form fields query
    When method POST
    Then status 200
    * print response

    Examples:
      |name     |status      |
      |abcd     |unavailable |
      |test     |pending     |


  @regression @CreateAndGetDetailsById
  Scenario Outline: update pet details by id

    Given url baseurl
    And request requestBody
    When method POST
    Then status 200
    * print response
    * def respId = response.id
    * print respId


    Given url baseurl
    And path respId
    When method GET
    Then status <statuscode>

    Examples:
      | statuscode |
      | 200        |


  @regression @CreateAndUpdateImageById
  Scenario: create and upload the image by id

    Given url baseurl
    And request requestBody
    When method POST
    Then status 200
    * print response
    * def respId = response.id
    * print respId

    * url baseurl
    Given path respId + '/uploadImage'
    And multipart file file  = {read : '../data/download.jpg', filename: 'MyFile' , contentType: 'image/jpg'}
    When method POST
    * print response
    * def resp = response.code
    * def respmessage = response.message
    * match resp contains response.code
    * match respmessage contains response.message
    Then status 200