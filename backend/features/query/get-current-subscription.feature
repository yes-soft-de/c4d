Feature: Request current subscriptions
  Scenario: Retrieve existing current subscriptions
    Given I am signed in user
    When I request current subscriptions
    Then I expect response code "200"
    And A json response with the required information