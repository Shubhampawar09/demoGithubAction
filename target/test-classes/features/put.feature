Feature: Put request to update pet details

  @regression @updatePetDetails
  Scenario Outline: update pet details

    * def requestBody =
    """
    {
  "id": '<id>',
  "category": {
    "id": 0,
    "name": '<categoryname>'
  },
  "name": '<name>',
  "photoUrls": [
    "string"
  ],
  "tags": [
    {
      "id": 0,
      "name": '<tag>'
    }
  ],
  "status": '<status>'
}
    """
#    * def query = {name : '<name>' , status : '<status>'}

    Given url baseurl
#    And form fields query
    And request requestBody
    When method PUT
    * print response
    Then status <actualstatus>
    Examples:
      |id       |name     |status       |categoryname  |actualstatus      |tag           |
      |1000     |tommy    |unavailable  |german        |200               |bruno         |
      |20       |test     |pending      |husky         |200               |leo           |


  Scenario Outline: update pet details

    * def random_integer =
    """
    function ranInteger(x) {
    if (x) {
        return new java.util.Random().nextInt(Math.pow(10, x));
    } else {
        return new java.util.Random().nextInt(100000000);
    }
}
    """
    * def randomInt = -random_integer(3)


    * def requestBody =
    """
    {
  "id": '#(randomInt)',
  "category": {
    "id": 0,
    "name": '<categoryname>'
  },
  "name": '<name>',
  "photoUrls": [
    "string"
  ],
  "tags": [
    {
      "id": 0,
      "name": '<tag>'
    }
  ],
  "status": '<status>'
}
    """
      Given url baseurl
#    And form fields query
      And request requestBody
      When method PUT
      * print response
      * print randomInt
      Then status <actualstatus>
      Examples:
       |name     |status       |categoryname  |actualstatus      |tag           |
       |tommy    |unavailable  |german        |200               |bruno         |
       |test     |pending      |husky         |200               |leo           |
