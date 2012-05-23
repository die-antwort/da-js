@javascript
Feature: Numeric value of input elements
  
  Background:
    Given I visit the test page for "numeric value"

  Scenario Outline: English locale
    When I fill in "textfield" with "<String>"
    Then the numeric value of "textfield" should be "<Value>"
    
    Examples:
      | String   | Value   |
      | 1        | 1       |
      | 1.2      | 1.2     |
      | 1234.56  | 1234.56 |
      | 1,234.56 | 1234.56 |
      | 1,234    | 1234    |
      | abc      | 0       |
      |          | 0       |

  Scenario Outline: German locale
    Given the HTML element has a lang attribute set to "de"
    When I fill in "textfield" with "<String>"
    Then the numeric value of "textfield" should be "<Value>"
    
    Examples:
      | String   | Value   |
      | 1        | 1       |
      | 1,2      | 1.2     |
      | 1234,56  | 1234.56 |
      | 1.234,56 | 1234.56 |
      | 1.234    | 1234    |
      | abc      | 0       |
      |          | 0       |
