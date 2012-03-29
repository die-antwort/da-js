require "active_support/inflector"

When /^I visit the test page for "([^"]*)"$/ do |feature|
  visit "/#{feature.parameterize '_'}"
end
