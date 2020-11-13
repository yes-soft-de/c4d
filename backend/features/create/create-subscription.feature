Feature: Create a new subscription
  Scenario: Create a new subscription with valid data
    Given I am signed in user
    And I have valid new subscription data
    When I request create a new subscription with the data I have
    Then I expect response code "200"
    And A json response with the new subscription information