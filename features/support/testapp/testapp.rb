require "sinatra"
require "sinatra/reloader" if development?
require "coffee_script"

set :app_file, __FILE__

before do
  @jquery_version = params[:jquery] || "1.7.1"
end

get "/vendor/:file" do |file|
  send_file settings.root + "/vendor/#{file}"
end

# Don't spam console/log with errors caused by a missing favicon
get "/favicon.ico" do
  404
end

get "/:view" do |view|
  erb view.to_sym
end
