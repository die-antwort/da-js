Then %r{^the "([^"]*)" input should be hidden$} do |input|
  find_field(input, visible: false).should_not be_visible
end

Then %r{^the "([^"]*)" input should be visible$} do |input|
  find_field(input).should be_visible
end

Then %r{^the "([^"]*)" element should be hidden$} do |selector|
  find(selector, visible: false).should_not be_visible
end

Then %r{^the "([^"]*)" element should be visible$} do |selector|
  find(selector).should be_visible
end

When %r{^I select "([^"]*)" from the "([^"]*)" select$} do |option, input|
  select option, :from => input
end

When %r{^I uncheck the "([^"]*)" checkbox$} do |input|
  uncheck input
end

When %r{^I check the "([^"]*)" checkbox$} do |input|
  check input
end

When %r{I enter "([^"]*)" in the "([^"]*)" field} do |value, input|
  fill_in input, with: value
end

When %r{I blur the "([^"]*)" field} do |input|
  find_field(input).trigger("blur")
end

When %r{^I set the "([^"]*)" checkbox to unchecked using JavaScript$} do |input|
  id = find_field(input)["id"]
  page.execute_script "$('##{id}')[0].checked = false"
end

When %r{^I trigger the "([^"]*)" event on the form$} do |event|
  page.execute_script "$('form').trigger('#{event}')"
end


