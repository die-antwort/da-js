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
    