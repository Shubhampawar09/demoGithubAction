Feature: Update pet details by id

@regression @updatePetDetailsById
Scenario Outline: update pet details by id

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
 * def randomInt = random_Integer(3)
 * def randomstr = randomString(5)

 * def requestUpdate =
  """
{
   "id":345,
   "category":{
      "id":0,
      "name":'<categoryname>'
   },
   "name":"ssffujh",
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

 * def query = {name : '<name>' , status : '<status>'}

Given url baseurl
And path respId
And form fields query
When method POST
* print response
Then status 200
Examples:
|name     |status      |
|abcd     |unavailable |
|test     |pending     |
