@javascript
Feature: Create jobs
  In order to create a job
  Gina should have to select both videos and tags for the job

   Background: Sign in as a Gina and then add some test videos and tags
      Given I am an admin user who is logged in
      Given a video called "Test Video"
      Given I want to create a "Test Tag" tag

  Scenario: Try to create a job without videos
    Given I am on new jobs
    And I should select a "Test Tag" tag for this new job
    Given I should select a "Test Tag" tag for this new job
    And I press the "Create Job" button
    Then I should see "Videos must have at least one selected"

  Scenario: Try to create a job without tags
    Given I am on new jobs
    And I should select a "Test Video" video for this new job
    And I press the "Create Job" button
    Then I should see "Tags must have at least one selected"

  Scenario: Try to create a job with videos and tags
    Given I am on new jobs
    And I should select a "Test Tag" tag for this new job
    And I should select a "Test Video" video for this new job
    And I press the "Create Job" button
    Then I should see "Job was successfully created."
