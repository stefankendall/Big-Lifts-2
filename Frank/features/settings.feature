Feature: Global Settings
  Scenario: Initial lbs/kg
    Given I launch the app
    When I touch "kg"
    When I touch "Starting Strength"
    When I tap the navigation icon
    When I touch "Settings"
    Then The "kg" segment is selected