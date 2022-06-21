Feature: Add pet to store

  Background:
#    * def createpet = read('../data/createPet.json')
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
   "status":"available"
}
  """

   @regression @createPetDetails
  Scenario: create pet details

    Given url baseurl
    And request requestBody
    When method POST
    Then status 200
    * print response