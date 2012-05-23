Given /^the HTML element has a lang attribute set to "([^"]*)"$/ do |lang|
  page.execute_script("$('html').attr('lang', '#{lang}')")
end

Then /^the numeric value of "([^"]*)" should be "([^"]*)"$/ do |input, value|
  page.evaluate_script("$('##{input}').numericValue()").should be_within(0.0001).of value.to_f
end
