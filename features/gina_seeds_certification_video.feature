@wip
Feature: Gina Seeds a Training Test
  In order to make sure a turk is trained to identify a tag
  As Gina
  I want to seed a certification video
  
  Background:
    Given a tag
    And an unseeded certification video for the tag
    And I am an admin user who is logged in
    And I am on the seed certification video page
    
  Scenario: Gina seeds the video
    When I apply the correct tags to a video
    And click "Done"
    Then I should see "seeded"
    And the certification video should be seeded
