RSpec::Matchers.define :be_marked_as_changed do 
  match do |element|
    element["class"].split(" ").include?("changed")   
  end
end

def find_element_and_label(element)
  id = "#{@form}_#{element}"
  [find("##{@form} ##{id}"), find("##{@form} label[for='#{id}']")]
end

def find_container(element)
  container = case @form
    when /^scaffold_form/ then "div[contains(@class, 'field')]"
    when /^formtastic/    then "li[contains(@class, 'input')]"
    else raise "I don't know about '#{@form}' forms ..."
    end
  within "##{@form}" do
    element_id = find_field(element)["id"]
    find :xpath, ".//#{container}[.//*[@id='#{element_id}']]"
  end
end

Given /^an? (empty|prefilled) (\w+)$/ do |type, form|
  visit "/form_change_tracker"
  @form = form.dup # Without #dup Cucumber prints the step incorrectly
  @form << "_prefilled" if type == "prefilled"
end


When /^I enter some text in the (\w+)$/ do |field|
  within "##{@form}" do
    fill_in field, :with => "foobar"
  end
end

When /^I change the (\w+)'s content$/ do |field|
  within "##{@form}" do
    fill_in field, :with => find_field(field).value + " plus some new text"
  end
end

When /^I clear the (\w+)$/ do |field|
  within "##{@form}" do
    fill_in field, :with => ""
  end
end

When /^I reset the (\w+) to its initial value$/ do |field|
  within "##{@form}" do
    fill_in field, :with => "text"
  end
end

When /^I (check|uncheck) the checkbox$/ do |action|
  within "##{@form}" do
    if action == "check"
      check "checkbox"
    else
      uncheck "checkbox"
    end
  end
end

When /^I choose the (first|second) radiobutton$/ do |which|
  button = (which == "first" ? "1" : (which == "second" ? "2" : "3"))
  within "##{@form}" do
    choose button
  end
end

When /^I select the (blank|first|second) option$/ do |which|
  option = (which == "blank" ? "" : (which == "first" ? "option 1" : "option 2"))
  within "##{@form}" do
    select option
  end
end

When /^I select the empty option$/ do
  within "##{@form}" do
    select ""
  end
end


Then /^no form element and label should be marked as changed$/ do
  within "##{@form}" do
    all("input,textarea,select,label").each do |element|
      element.should_not be_marked_as_changed
    end
  end
end

Then /^no field container should be marked as changed$/ do
  within "##{@form}" do
    all(".field").each do |element|
      element.should_not be_marked_as_changed
    end
  end
end

Then /^the (first|second|third) radiobutton's form element and label should( not| no longer)? be marked as changed$/ do |which, no_longer|
  button = (which == "first" ? "1" : (which == "second" ? "2" : "3"))
  element, label = find_element_and_label("radiobutton_#{button}")
  if no_longer
    element.should_not be_marked_as_changed
    label.should_not be_marked_as_changed
  else
    element.should be_marked_as_changed
    label.should be_marked_as_changed
  end
end

Then /^the (first|second|third) radiobutton's field container should( not| no longer)? be marked as changed$/ do |which, no_longer|
  button = (which == "first" ? "1" : (which == "second" ? "2" : "3"))
  container = find_container("radiobutton #{button}")
  if no_longer
    container.should_not be_marked_as_changed
  else
    container.should be_marked_as_changed
  end
end

Then /^the (\w+)'s form element and label should( no longer)? be marked as changed$/ do |element, no_longer|
  element, label = find_element_and_label(element)
  if no_longer
    element.should_not be_marked_as_changed
    label.should_not be_marked_as_changed
  else
    element.should be_marked_as_changed
    label.should be_marked_as_changed
  end
end

Then /^the (\w+)'s field container should( no longer)? be marked as changed$/ do |element, no_longer|
  container = find_container(element)
  if no_longer
    container.should_not be_marked_as_changed
  else
    container.should be_marked_as_changed
  end
end
