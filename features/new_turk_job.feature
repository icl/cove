Feature: New Turk Job
  In order to get large videos coded quickly
  As Gina
  I should be able to create and dispatch a turk job
  
  Background:
    Given I am Gina
  
  Scenario: Create a job
    Given I am on the turk jobs page
    When I follow "New job"
    And I fill in "Description" with "Find instances of riffing in days 1-5"
    And I fill in "Days" with "1-5"
    And I fill in "Funds allocated" with "100"
    And I fill in "Award per tag" with ".02"
    And I press "Submit"
    Then I should be on the turk job page for "Find instances of riffing in days 1-5"
    And I should see "Turk job created"
    