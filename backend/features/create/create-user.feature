Feature: Register a new user
  Scenario: Register a new user with valid data
    Given I have access to backend
    And I have valid new user data
    When I request create a new user with the data I have
    Then I expect response code "200"
    And A json response with the new user information