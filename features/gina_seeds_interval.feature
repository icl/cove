Feature: Seed Interval
  In order to prepare the system for turks to tag intervals
  As Gina
  I want to seed a tag by applying it myself

  Background:
    Given a tag with name "riffing" and 10 tags with a threshold of 10
    And a turk job with tag "riffing"
    
  Scenario: Incompletely seed interval
    When I tag region [10, 50]
    And I tag region [100, 200]
    And I follow "Done"
    Then I should see "Tag riffing seeded"

  Scenario: Completely seed interval
    When I tag region [10, 50]
    And I follow "Done"
    Then I should see "Tag count: 11 of 12 needed"

