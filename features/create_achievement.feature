Feature: Create Achievement

  I want create a new Achievement
  with valid data

  Scenario: create new achievement with valid data
    Given I'm a logged user
    And Data has to be valid
    And I create a new achievement with the valid data
    Then I must see a success notice
    And I must see the last article

  Scenario: cannot create new achievement with invalid data
    Given I'm a logged user
    And I create a new achievement with invalid data
    Then I must see an error message for the title validation

