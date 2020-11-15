Feature: Update a specific package
  Scenario: Update an existed package
    Given I am signed in admin
    And I have new package information of ID "10"
    When I request update an existed package
    Then I expect the response update successfully
    And I expect the response match the new package information