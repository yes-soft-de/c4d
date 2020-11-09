Feature: Register a new admin
  Scenario: Register a new admin with valid data
    Given I have access to backend
    And I have valid new admin data
    When I request create a new admin with the data I have
    Then I expect response code "200"
    And A json response with the new admin information