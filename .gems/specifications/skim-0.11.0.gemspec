# -*- encoding: utf-8 -*-
# stub: skim 0.11.0 ruby lib

Gem::Specification.new do |s|
  s.name = "skim".freeze
  s.version = "0.11.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["AppJudo Inc.".freeze]
  s.date = "2021-03-02"
  s.description = "Fat-free client-side templates with Slim and CoffeeScript".freeze
  s.email = ["info@appjudo.com".freeze]
  s.executables = ["skim".freeze]
  s.files = ["bin/skim".freeze]
  s.homepage = "".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.2.33".freeze
  s.summary = "Take the fat out of your client-side templates with Skim. Skim is the Slim templating engine with embedded CoffeeScript. It compiles to JavaScript templates (.jst), which can then be served by Rails or any other Sprockets-based asset pipeline.".freeze

  s.installed_by_version = "3.2.33" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<slim>.freeze, [">= 3.0"])
    s.add_runtime_dependency(%q<coffee-script>.freeze, [">= 0"])
    s.add_runtime_dependency(%q<coffee-script-source>.freeze, [">= 1.2.0"])
    s.add_runtime_dependency(%q<sprockets>.freeze, [">= 2.0", "< 5.0"])
    s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    s.add_development_dependency(%q<pry>.freeze, [">= 0"])
    s.add_development_dependency(%q<execjs>.freeze, [">= 0"])
    s.add_development_dependency(%q<minitest-reporters>.freeze, [">= 0"])
    s.add_development_dependency(%q<libv8>.freeze, ["~> 8.4"])
  else
    s.add_dependency(%q<slim>.freeze, [">= 3.0"])
    s.add_dependency(%q<coffee-script>.freeze, [">= 0"])
    s.add_dependency(%q<coffee-script-source>.freeze, [">= 1.2.0"])
    s.add_dependency(%q<sprockets>.freeze, [">= 2.0", "< 5.0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<pry>.freeze, [">= 0"])
    s.add_dependency(%q<execjs>.freeze, [">= 0"])
    s.add_dependency(%q<minitest-reporters>.freeze, [">= 0"])
    s.add_dependency(%q<libv8>.freeze, ["~> 8.4"])
  end
end
