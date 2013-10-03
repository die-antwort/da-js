@javascript
Feature: Conditional visibility for elements
  
  Background:
    Given I visit the test page for "conditional visibility"

  Scenario: Basic functionality
    Then the "Other Country" input should be hidden
    But the "Message" input should be visible
     
    When I select "Other …" from the "Country" select
    Then the "Other Country" input should be visible
    
    When I uncheck the "I want to leave a message" checkbox
    Then the "Message" input should be hidden
    
    When I select "Austria" from the "Country" select
    Then the "Other Country" input should be hidden
    
    When I check the "I want to leave a message" checkbox
    Then the "Message" input should be visible
    
  Scenario: Changing a field value via javascript and triggering the event manually
    When I set the "I want to leave a message" checkbox to unchecked using JavaScript
    Then the "Message" input should be visible
    
    When I trigger the "updateVisibilities" event on the form
    Then the "Message" input should be hidden


  Scenario: Manually configuring events triggering visibility re-calculations
    # Assert default behaviour first
    When I enter "foo" in the "amount" field
    Then the "#amount_info" element should be hidden
    When I blur the "amount" field
    Then the "#amount_info" element should be visible
    
    Given I visit the test page for "conditional visibility" with options "{events: 'keypress'}"
    Then the "#amount_info" element should be hidden
    When I enter "foo" in the "amount" field
    Then the "#amount_info" element should be visible
    
    
  Scenario: Using the triggered events
    Given I bind an event listener to "shown.conditionalVisibility"
    And I bind an event listener to "hidden.conditionalVisibility"
    When I select "Other …" from the "Country" select
    Then the event listener for "shown.conditionalVisibility" should have been called "1" time
    And the event listener for "hidden.conditionalVisibility" should have been called "0" times
    When I select "Austria" from the "Country" select
    Then the event listener for "shown.conditionalVisibility" should have been called "1" times
    And the event listener for "hidden.conditionalVisibility" should have been called "1" times
    
    
    