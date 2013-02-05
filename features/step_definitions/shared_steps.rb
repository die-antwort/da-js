require "active_support/inflector"
require "active_support/core_ext/object/to_query"

When %r{^I visit the test page for "([^"]*)"$} do |feature|
  visit "/#{feature.parameterize '_'}"
end

When %r{^I visit the test page for "([^"]*)" with options "([^"]*)"?$} do |feature, options|
  visit "/#{feature.parameterize '_'}?" + {options: options}.to_query
end

When %r{^I fill in "([^"]*)" with "([^"]*)"$} do |input, value|
  fill_in input, :with => value
end

