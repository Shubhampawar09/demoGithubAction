Feature: Post request using image

  @regression @uploadImage
  Scenario Outline: upload image using post

    * url baseurl
    Given path "<id>/uploadImage"
    And multipart file file  = {read : '../data/download.jpg', filename: 'MyFile' , contentType: 'image/jpg'}
    When method POST
    * print response
    * def resp = response.code
    * def respmessage = response.message
    * match resp contains response.code
    * match respmessage contains response.message
    Then status 200
    Examples:
      |id    |
      |25    |
