Feature: Login by registered user
  Scenario: Login by valid credentials
    Given I have access to backend
    And I have valid user credentials
    When I request login check
    Then I expect a token within the response