Feature: Request the active packages
  Scenario: Retrieve the active packages
    Given I am signed in user
    When I request active packages
    Then I expect response code "200"
    And A json response with the required information