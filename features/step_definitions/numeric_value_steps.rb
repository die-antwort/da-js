Given %r{the HTML element has a lang attribute set to "([^"]*)"$} do |lang|
  page.execute_script("$('html').attr('lang', '#{lang}')")
end

Given %r{the element "([^"]*)" has a lang attribute set to "([^"]*)"$} do |id, lang|
  page.execute_script("$('##{id}').attr('lang', '#{lang}')")
end

Then %r{^the numeric value of "([^"]*)" should be "([^"]*)"$} do |input, value|
  page.evaluate_script("$('##{input}').numericValue()").should be_within(0.0001).of value.to_f
end

Then %r{^the numeric value \(ignoring currency sign\) of "([^"]*)" should be "([^"]*)"$} do |input, value|
  page.evaluate_script("$('##{input}').numericValue({ignoreCurrencySign: true})").should be_within(0.0001).of value.to_f
end

Then %r{^the numeric value \(using `nullOnError: true`\) of "([^"]*)" should be "([^"]*)"$} do |input, value|
  actual = page.evaluate_script("$('##{input}').numericValue({nullOnError: true})")
  if value == "null"
    actual.should eq("") 
  else
    actual.should be_within(0.0001).of(value.to_f)
  end
end

