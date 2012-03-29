Then /^the "([^"]*)" input should be hidden$/ do |input|
  find_field(input).should_not be_visible
end

Then /^the "([^"]*)" input should be visible$/ do |input|
  find_field(input).should be_visible
end

When /^I select "([^"]*)" from the "([^"]*)" select$/ do |option, input|
  select option, :from => input
end

When /^I uncheck the "([^"]*)" checkbox$/ do |input|
  uncheck input
end

When /^I check the "([^"]*)" checkbox$/ do |input|
  check input
end

When /^I set the "([^"]*)" checkbox to unchecked using JavaScript$/ do |input|
  id = find_field(input)["id"]
  page.execute_script "$('##{id}')[0].checked = false"
end

When /^I trigger the "([^"]*)" event on the form$/ do |event|
  page.execute_script "$('form').trigger('#{event}')"
end


