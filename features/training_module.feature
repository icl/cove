Feature: Create training module
  In order for a turk to become trained
  The turk should go through some training for a tag
  I should be able to create a training module and attach it to a video

   Background: Create an admin user to test with and sign in
      Given I am an admin user who is logged in
      Then I should see "Signed in successfully."

  Scenario: Create a new training module
    Given I am on new training modules
    And I should select a video
    And I should select a tag
    And I should enter a name
    And I should enter a description
    And I press the "add" button
    Then I should see "Training Module Created"

  Scenario: Select a training video to edit
    When I am on the training module list page
    And I select "module" 1
    And I press the "edit" button
    Then I should be on the edit page

  Scenario: Edit a training module to change a video
    When I am on the training module edit page
    And I press the "remove video" button
    And I select a "video" from the "training video" dropdown
    And I press the "add video" button
    And I press the "save module" button
    Then I should see "Training Module Updated"

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
