Feature: Turk Tags a Video
  In order to make money/perform my assigned job
  As a Turk
  I want to code videos
  
  Background:
    Given a turk job
    And I am a turk who is logged in
    And I am on the work page
  
  @javascript
  Scenario: Tag a range using the hold button
    When I click the play button
    And I tag the range [1,3] using the hold-to-tag button
    Then a code should be created for the video with approximate range [1,3]
  
  @javascript
  Scenario: Code a range using the toggle button
    When I click the play button
    And I tag the range [1,3] using the click-to-tag button
    Then a code should be created for the video with approximate range [1,3]
