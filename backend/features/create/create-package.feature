Feature: Create a new package
  Scenario: Create a new package with valid data
    Given I am signed in admin
    And I have valid new package data
    When I request create a new package with the data I have
    Then I expect response code "200"
    And A json response with the new package information