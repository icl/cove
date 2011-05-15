Feature: Create training module
  In order for a turk to become trained
  The turk should go through some training for a tag
  I should be able to create a training module and attach it to a video

   Background: Create an admin user to test with and sign in
      Given I am an admin user who is logged in
      Then I should see "Signed in successfully."

  Scenario: Create a new training module
    Given I want to create a "Test Video" training video located in "/videos/trainings/test.mp4"
    Then A "Test Video" training video should exist
    Given I want to create a "Test Tag" tag
    Then A "Test Tag" tag should exist
    Given I am on new training modules
    And I should select a "Test Video" video
    And I should select a "Test Tag" tag
    And I should enter a "Test Title" title
    And I should enter a "Test Title" description
    And I press the "Create Training" button
    Then I should see "Training module was successfully created."

  Scenario: Select a training video to edit
      Given I want to create a "Test Video" training video located in "/videos/trainings/test.mp4"
      Then A "Test Video" training video should exist
      Given I want to create a "Test Tag" tag
      Then A "Test Tag" tag should exist
      Given I want to create a "Test Module" training module with description "Test Module Description" bound to tag "Test Tag" and bound to video "Test Video"
      Then A training module should exist with title "Test Module" and description "Test Module Description" bound to tag "Test Tag" and bound to video "Test Video"
      When I am on the training module list page
      And I follow "Edit"
      Then I should be on the training edit page

  Scenario: Edit a training module to change a video
    Given I want to create a "Test Video" training video located in "/videos/trainings/test.mp4"
    Then A "Test" training video should exist
    Given I want to create a "Test Video 2" training video located in "/videos/trainings/test2.mp4"
    Then A "Test2" training video should exist
    Given I want to create a "Test Tag" tag
    Then A "Test" tag should exist
    Given I want to create a "Test Tag 2" tag
    Then A "Test2" tag should exist
    Given I want to create a "Test Module" training module with description "Test Module Description" bound to tag "Test Tag" and bound to video "Test Video"
    Then A training module should exist with title "Test Module" and description "Test Module Description" bound to tag "Test Tag" and bound to video "Test Video"
    When I am on the training edit page
    And I should select a "Test Video 2" video
    And I should select a "Test Tag 2" tag
    And I should enter a "Test Title Nieu" title
    And I should enter a "Test Title Nieu Description" description
    And I press the "Update Training" button
    Then I should see "Training was successfully updated."
    Then A training module should exist with title "Test Module Nieu" and description "Test Module Description Nieu" bound to tag "Test Tag 2" and bound to video "Test Video 2"

  Scenario: Selecting a module add tags to
    When I am on the training module list page
    And I select "module" 1
    And I press the "attach" button
    Then I should be on the attach tag page

  Scenario: Edit a training module to change tags
    When I am on the training module edit page
    And I press the "remove tag" button
    And I select a "tag" from the "tag" dropdown
    And I press the "add tag" button
    Then I should see "Training Module Updated"

  Scenario: Attaching a training module
    When I am on the attach tag page for video 1
    And I select "tag" 1
    And I press the "attach" button
    Then I should see "Training Module Updated"

  Scenario: Delete a training module
    When I am on the training module list page
    And I select "module" 1
    And I press the "delete" button
    And I press the "confirm" button
    Then I should see "Training Module Deleted"
