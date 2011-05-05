Feature: Turk Codes a Video
  In order to make money/perform my assigned job
  As a Turk
  I want to code videos
  
  Background:
    Given a turk job
    And I am on the work page
  
  @javascript
  Scenario: Code a range using the hold button
    When I click the play button
    And I wait 1 seconds
    And I press the hold-to-code button
    And I wait 2 seconds
    And I release the hold-to-code button
    Then a code should be created for the video with approximate range [1,3]
  
  @javascript
  Scenario: Code a range using the toggle button
    When I click the play button
    And I wait 1 seconds
    And I click the click-to-code button
    And I wait 2 seconds
    And I click the click-to-code button
    Then a code should be created for the video with approximate range [1,3]
