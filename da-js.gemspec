# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "da-js/version"

Gem::Specification.new do |s|
  s.name        = "da-js"
  s.version     = Da::Js::VERSION
  s.authors     = ["Stefan Daschek"]
  s.email       = ["stefan@die-antwort.eu"]
  s.homepage    = "https://github.com/die-antwort/da-js"
  s.summary     = "Mixed jQuery extensions"
  s.description = "Some jQuery extensions we tend to use in almost all our projects."

  s.rubyforge_project = "da-js"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "railties", ">= 3.1.0"
  s.add_dependency "sprockets", "~> 2.0"
  
  s.add_development_dependency "cucumber", ">= 1.1.4"
  s.add_development_dependency "rspec-expectations", ">= 2.7.0"
  s.add_development_dependency "sinatra"
  s.add_development_dependency "sinatra-contrib"
  s.add_development_dependency "capybara", ">= 1.1.2"
  s.add_development_dependency "capybara-webkit", ">= 0.8.0"
  s.add_development_dependency "launchy"
end
