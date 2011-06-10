Feature: Creating a new tag
As a administrator, I can fill out the name and description field of a tag, and when I click Create Tag, the Tag is saved.

Background: 
Given I am an admin user who is logged in

Scenario: Save tag
   When I am on the new tag page 	
   And I fill in "Name" with "Riffing"
   And I fill in "Description" with "Riffing Description"
   And I press "Save tag" 
   Then I should see "Tag was successfully created."
   
Scenario: Save tag and Create Job 
   When I am on the new tag page 	
   And I fill in "Name" with "Riffing"
   And I fill in "Description" with "Riffing Description"
   And I press "Save tag and Create Job" 
   Then I should be on the new job page
   And I should see "Tag was successfully created."
   And "Riffing" should be selected from the tags