Feature: Turk Takes Certification Test
  In order to become certified to work on a job
  As a Turk
  I want to pass the certification test
  
  Background:
    Given a tag
    And a seeded certification video for the tag
    And I am a turk who is logged in
    And I am on the certification test page
  
  @javascript
  Scenario: Pass test
    When I apply the correct tags to a video
    And I follow "Submit Test"
    Then I should see "passed"
    And I should be certified for the tag
  
  @javascript
  Scenario: Fail test
    When I apply the wrong tags to a video
    And I follow "Submit Test"
    Then I should see "failed"
    And I should not be certified for the tag
