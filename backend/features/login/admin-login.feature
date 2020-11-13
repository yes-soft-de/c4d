Feature: Login by registered admin
  Scenario: Login by valid credentials
    Given I have access to backend
    And I have valid admin credentials
    When I request login check
    Then I expect a token within the response