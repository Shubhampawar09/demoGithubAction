Feature: delete pet details by id

  @regression @deletePetDetailsById
  Scenario: delete pet details by id

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
  * def rand = random_Integer(3)
  * def randomString = randomStr(5)

    * def requestBody =
  """
{
   "id":'#(rand)',
   "category":{
      "id":0,
      "name":""
   },
   "name":'#(randomString)',
   "photoUrls":[
      "string"
   ],
   "tags":[
      {
         "id":0,
         "name":"string"
      }
   ],
   "status":'#(randomString)'
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
    When method DELETE
    * print response
    * def resp = response.code
    * def respmessage = response.message
    * match resp contains response.code
    * match respmessage contains response.message
    Then status 200
