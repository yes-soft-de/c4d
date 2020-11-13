Feature: Request packages by the location of the owner
  Scenario: Retrieve existing packages by location
    Given I have access to backend
    When I request packages for location "fixture city"
    Then I expect response code "200"
    And A json response with the required information