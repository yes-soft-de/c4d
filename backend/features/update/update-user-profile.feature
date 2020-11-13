Feature: Update the profile of signed in user
  Scenario: Update the profile of signed in user
    Given I am signed in user
    And I have new profile information
    When I request update my profile
    Then I expect the response update successfully
    And I expect the response match the new information
