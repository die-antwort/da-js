require "active_support/inflector"

When /^I visit the test page for "([^"]*)"$/ do |feature|
  visit "/#{feature.parameterize '_'}"
end

When /^I fill in "([^"]*)" with "([^"]*)"$/ do |input, value|
  fill_in input, :with => value
end

