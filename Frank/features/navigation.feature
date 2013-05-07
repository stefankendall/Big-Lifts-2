Feature: Navigation
  Scenario: Program
    Given I launch the app
    When I touch "Starting Strength"
    When I tap the navigation icon
    When I touch "Program"
    Then I should see "Programs"

  Scenario: Settings
    Given I launch the app
    When I touch "Starting Strength"
    When I tap the navigation icon
    When I touch "Settings"
    Then I should not see "Program"
    When I tap the navigation icon
    Then I should see "Program"

