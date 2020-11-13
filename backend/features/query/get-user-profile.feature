Feature: Retrieve the profile of a user
  Scenario: Retrieve the profile of signed in user
    Given I am signed in user
    When I request my profile
    Then I expect response code "200"
    And A json response with my information