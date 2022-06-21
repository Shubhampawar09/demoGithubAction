Feature: negative testcases for pet

  @regression @negativeGetPetDetails
  Scenario Outline: negative testcase for get request
  Given url baseurl
  And path <id>
  When method GET
  Then status <statuscode>
  Examples:
  |id       | statuscode |
  |''       |405         |
  |-1       |404         |
  |1.678    |404         |
  |1000     | 200        |

  @regression @negativeDeletePetDetails
    Scenario Outline: negative testcase for delete request
    Given url baseurl
    And path <id>
    When method DELETE
    * print response
    * def resp = response.code
    * def respmessage = response.message
    * match resp contains response.code
    * match respmessage contains response.message
    Then status <status>
    Examples:
      |id        |status   |
      |'abc'     |404      |
      |1.6578    |404      |
      |-1        |404      |

  @regression @negativeCreatePetDetails
  Scenario Outline: create pet details

    * def requestBody =
  """
{
   "id":'<id>',
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
   "status":"available"
}
  """

    Given url baseurl
    And request requestBody
    When method POST
    Then status <status>
    * print response
    Examples:
      |id       |status   |
      |syav     |500      |
      |-1       |200      |


  @regression @negativeUploadImage
  Scenario Outline: upload image using post

    * def randomStr =
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
    * def rand = random_Integer(2)
    * def randString = randomStr(5)

    * def requestBody =
  """
{
   "id":'<id>',
   "category":{
      "id":0,
      "name":""
   },
   "name":'#(randString)',
   "photoUrls":[
      "string"
   ],
   "tags":[
      {
         "id":0,
         "name":"string"
      }
   ],
   "status":'#(randString)'
}
  """

    * url baseurl

#    And multipart file file  = {read : 'download.jpg', filename: 'MyFile' , contentType: 'image/jpg'}
    And request requestBody
    Given path <id> + '/uploadImage'
    When method POST
    * def resp = response.code
    * def respmessage = response.message
    * match resp contains response.code
    * match respmessage contains response.message
    Then status <status>
    Examples:
      |id     |status  |
      |25     |415     |
      |282    |415     |

