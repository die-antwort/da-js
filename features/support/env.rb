require "rails/engine"
require "capybara/cucumber"
require "capybara-webkit"
require "rack"

Capybara.javascript_driver = :webkit
Capybara.app, _ = Rack::Builder.parse_file(File.dirname(__FILE__) + "/testapp/config.ru")