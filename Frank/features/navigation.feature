Feature: Navigation
  Scenario:
    Given I launch the app
    When I touch "Starting Strength"
    When I tap the navigation icon
    When I touch "Program"
    Then I should see "Programs"
