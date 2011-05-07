Feature: Turk Tags an Interval
  In order to make money
  As a Turk
  I want to find a job tagging intervals
  
  Scenario: Select a job
    Given a dispatchable turk job
    When I click on "Start working"
    Then I should be on the turk page
