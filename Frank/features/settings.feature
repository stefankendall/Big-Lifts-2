Feature: Global Settings

  Scenario: Initial lbs/kg
    Given I launch the app
    When I touch "kg"
    When I touch "Starting Strength"
    When I tap the navigation icon
    When I touch "Settings"
    Then The "kg" segment is selected

  Scenario: Settings changing units
    Given I launch the app
    When I touch "kg"
    When I touch "Starting Strength"
    When I tap the navigation icon
    When I touch "Settings"
    And I touch "lbs"
    And I tap the navigation icon
    And I touch "Program"
    Then The "lbs" segment is selected