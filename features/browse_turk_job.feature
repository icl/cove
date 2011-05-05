Feature: Browse Turk Jobs
  In order to find an existing turk job
  As Gina or as a turk
  I should be able to see a list of turk jobs

  Background:
    Given a dispatched turk job with the title "dispatched turk job"
    And an undispatched turk job with the title "undispatched turk job"

  
  Scenario: Anyone browsing
    When I am on the turk jobs page
    Then I should see "dispatched turk job"
    
  Scenario: Gina is browsing
    Given I am Gina
    When I am on the turk jobs page
    Then I should see "undispatched turk job"
    And I should see "edit"
    And I should see "new"
    
  Scenario: Turk is browsing
    Given I am a turk
    When I am on the turk jobs page
    Then I should not see "undispatched turk job"
    And I should not see "edit"
    And I should not see "new" 
  
