Feature: Example

  Scenario: Image compairison example
    Given I at at Google Homepage
    When I search for "Rocket"
    Then I assert layout to be the same
