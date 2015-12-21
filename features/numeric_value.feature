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
      | $ 3      | 0       |
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
      | € 5      | 0       |
      |          | 0       |

  Scenario: Locale specified on the input element directly
    Given the HTML element has a lang attribute set to "de"
    And the element "textfield" has a lang attribute set to "en"
    When I fill in "textfield" with "1,234.56"
    Then the numeric value of "textfield" should be "1234.56"

  Scenario: Reading value from non-input elements
    Then the numeric value of "non_input_element_english" should be "1234.56"
    Given the HTML element has a lang attribute set to "de"
    Then the numeric value of "non_input_element_german" should be "5678.9"
    
  Scenario Outline: Ignoring the currency sign
    When I fill in "textfield" with "<String>"
    Then the numeric value (ignoring currency sign) of "textfield" should be "<Value>"
    Examples:
      | String   | Value   |
      | € 1      | 1       |
      | $123.45  | 123.45  |
      | $$ 3     | 0       |
      | €$ 7     | 0       |
      
  Scenario Outline: Using `nullOnError`
    When I fill in "textfield" with "<String>"
    Then the numeric value (using `nullOnError: true`) of "textfield" should be "<Value>"
    Examples:
      | String   | Value   |
      | 1,234    | 1234    |
      | abc      | null    |
      | € 5      | null    |
