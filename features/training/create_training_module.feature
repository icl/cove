Feature: Create training module
  In order for a turk to become trained
  The turk should go through some training for a tag
  I should be able to create a training module and attach it to a video

  Background:
    Given I am a new, authenticated user with administrator privileges

  Scenario: Create a new training module
    When I am on the new training module page
    Then I should select a video
    And I should select a tag
    And I press the "add" button
    Then I should be on the confirmation page

  Scenario: Select a training video to edit
    When I am on the training module list page
    And I select module 1
    And I press the "edit" button
    Then I should be on the edit page

  Scenario: Edit a training module to change a video
    When I am on the training module edit page
    And I press the "remove video" button
    And I select a video from the "training video" dropdown
    And I press the "add video" button
    And I press the "save module" button
    Then I should be on the confirmation page

  Scenario: Delete a training module
    When I am on the training module list page
    And I select module 1
    And I press the "delete" button
    And I press the "confirm" button
    Then I should be on the confirmation page

  Scenario: Selecting a module add tags to
    When I am on the training module list page
    And I select module 1
    And I press the "attach" button
    Then I should be on the attach tag page

  Scenario: Attaching a training module
    When I am on the attach tag page
    And I select tag 1
    And I press the "attach" button
    Then I should be on the confirmation page
