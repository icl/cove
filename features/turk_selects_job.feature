Feature: Turk Selects Job
  In order to make money/perform my assigned job
  As a turk
  I want to select a job to work on 
  
  Background:
    Given a turk job
    And I am a turk who is logged in
    
  Scenario: From the job list page
    Given I am on the jobs page
    When I follow "Work"
    Then I should be on the work page
