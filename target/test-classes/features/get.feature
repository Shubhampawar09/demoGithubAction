Feature: Fetch Pet

  @regression @GetDetailsById
  Scenario: Fetch pet by id

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
   "status":"available"
}
  """

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


  @regression @GetDetailsByStatus
  Scenario Outline: Fetch pet by status
    * def query = {status : '<responseBody>' , status : '<responseBody>' , status : '<responseBody>' , status : '<responseBody>'}
    Given url baseurl
    And path 'findByStatus'
    And params query
    When method GET
    Then status <statuscode>
#    * print response
#    * match response == '<responseBody>'
    Examples:
       | statuscode | responseBody   |
       | 200        |  available     |
       | 200        |  pending       |
       | 200        |  sold          |
       | 200        |                |