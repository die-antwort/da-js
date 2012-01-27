@javascript
Feature: Change tracker for forms
  There are two special cases:
   - A select has always a selected option. We use the first option (with empty value) as "empty".
   - All radiobuttons can initially be unselected, but going back to this state is impossible. So, in the "empty form" scenario, we skip the radiobutton in second part (when we test "resetting" the form elements)
  
  Scenario Outline: An empty form 
    Given an empty <Form>
    Then no <Element> should be marked as changed
     
    When I enter some text in the textfield
    Then the textfield's <Element> should be marked as changed
    
    When I enter some text in the textarea
    Then the textarea's <Element> should be marked as changed
    
    When I check the checkbox
    Then the checkbox's <Element> should be marked as changed
    
    When I select the first option
    Then the select's <Element> should be marked as changed
    
    # Now for resetting everything (except radiobuttons, see feature description)
    When I clear the textfield
    Then the textfield's <Element> should no longer be marked as changed
    
    When I clear the textarea
    Then the textarea's <Element> should no longer be marked as changed
    
    When I uncheck the checkbox
    Then the checkbox's <Element> should no longer be marked as changed

    When I select the empty option
    Then the select's <Element> should no longer be marked as changed
    
    Examples:
      | Form          | Element                |
      | simple_form   | form element and label |
      | scaffold_form | field container        |

  
  Scenario: Radiobuttons in an empty simple form
    Given an empty simple_form
    When I choose the first radiobutton
    Then the first radiobutton's form element and label should be marked as changed
    But the second radiobutton's form element and label should not be marked as changed
    And the third radiobutton's form element and label should not be marked as changed

     
  Scenario: Radiobuttons in an empty scaffold form
    Given an empty scaffold_form
    When I choose the first radiobutton
    Then the first radiobutton's field container should be marked as changed
  
 
  Scenario Outline: A prefilled form 
    Given a prefilled <Form>
    Then no <Element> should be marked as changed
     
    When I change the textfield's content
    Then the textfield's <Element> should be marked as changed
    When I clear the textfield
    Then the textfield's <Element> should be marked as changed
    
    When I change the textarea's content
    Then the textarea's <Element> should be marked as changed
    When I clear the textarea
    Then the textarea's <Element> should be marked as changed
    
    When I uncheck the checkbox
    Then the checkbox's <Element> should be marked as changed
    
    When I select the second option
    Then the select's <Element> should be marked as changed
    
    # Now reset everything again
    When I reset the textfield to its initial value
    Then the textfield's <Element> should no longer be marked as changed
    
    When I reset the textarea to its initial value
    Then the textarea's <Element> should no longer be marked as changed
    
    When I check the checkbox
    Then the checkbox's <Element> should no longer be marked as changed

    When I select the first option
    Then the select's <Element> should no longer be marked as changed

    And no <Element> should be marked as changed

    Examples:
      | Form          | Element                |
      | simple_form   | form element and label |
      | scaffold_form | field container        |


  Scenario: Radiobuttons in an prefilled simple form
    Given an prefilled simple_form
    Then no form element and label should be marked as changed
  
    When I choose the second radiobutton
    Then the second radiobutton's form element and label should be marked as changed
    And the first radiobutton's form element and label should be marked as changed
    But the third radiobutton's form element and label should not be marked as changed
    
    When I choose the first radiobutton
    Then no form element and label should be marked as changed    

     
  Scenario: Radiobuttons in an prefilled scaffold form
    Given an prefilled scaffold_form
    Then no form element and label should be marked as changed
    
    When I choose the second radiobutton
    Then the second radiobutton's field container should be marked as changed

    When I choose the first radiobutton
    Then no form element and label should be marked as changed
  
