Feature: Achievement Page

  In order to read others achievements
  As a guest user
  I want to see public achievement

  Scenario: guest user sees public achievement
    Given I am a guest user
    And there is a public achievement
    When I go to the achievement's page
    Then I must see achievement's content

  Scenario: render description as markdown
    Given Content with markdown inside
    When I go the achievement's page
    Then Markdown has to be converted to HTML tags