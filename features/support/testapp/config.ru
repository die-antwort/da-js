require 'sprockets'
require File.dirname(__FILE__) + "/testapp"

map '/assets' do
  environment = Sprockets::Environment.new
  environment.append_path File.dirname(__FILE__) + '/../../../lib/assets'
  run environment
end

map '/' do
  run Sinatra::Application
end
