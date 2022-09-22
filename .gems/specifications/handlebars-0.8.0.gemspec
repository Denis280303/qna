# -*- encoding: utf-8 -*-
# stub: handlebars 0.8.0 ruby lib

Gem::Specification.new do |s|
  s.name = "handlebars".freeze
  s.version = "0.8.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Charles Lowell".freeze]
  s.date = "2016-04-05"
  s.description = "Uses the actual JavaScript implementation of Handlebars, but supports using Ruby objects as template contexts and Ruby procs as view functions and named helpers".freeze
  s.email = ["cowboyd@thefrontside.net".freeze]
  s.homepage = "https://github.com/cowboyd/handlebars.rb".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.2.33".freeze
  s.summary = "Ruby bindings for the handlebars.js templating library".freeze

  s.installed_by_version = "3.2.33" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<therubyracer>.freeze, ["~> 0.12.1"])
    s.add_runtime_dependency(%q<handlebars-source>.freeze, ["~> 4.0.5"])
    s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    s.add_development_dependency(%q<rspec>.freeze, ["~> 2.0"])
  else
    s.add_dependency(%q<therubyracer>.freeze, ["~> 0.12.1"])
    s.add_dependency(%q<handlebars-source>.freeze, ["~> 4.0.5"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 2.0"])
  end
end
