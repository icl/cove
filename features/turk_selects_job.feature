Feature: Turk Selects Job
  In order to make money/perform my assigned job
  As a turk
  I want to select a job to work on 
  
  Background:
    Given I am a turk who is logged in
    
  Scenario: From the job list page
    Given a turk job
    And I am on the jobs page
    When I follow "Work"
    Then I should be on the work page

  Scenario: From the work page
   Given 2 turk jobs
   And I am on the work page for job 2
   When I follow "Back to jobs"
   And I follow "Work"
   Then I should be on the work page for job 1