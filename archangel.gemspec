# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("../lib", __FILE__)

require "archangel/version"

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = "archangel"
  s.version     = Archangel::VERSION
  s.authors     = ["David Freerksen"]
  s.email       = ["dfreerksen@gmail.com"]
  s.homepage    = "https://github.com/archangel/archangel"
  s.summary     = "Summary of Archangel."
  s.description = "Description of Archangel."
  s.license     = "MIT"
  s.files       = `git ls-files`.split($ORS)

  s.required_ruby_version = ">= 2.2.3"

  s.add_dependency "jquery-rails", ">= 4.1.0"
  s.add_dependency "rails", "~> 5.1.4"
  s.add_dependency "sass-rails", ">= 5.0.0"
  s.add_dependency "uglifier", ">= 2.7"

  s.add_dependency "devise", "~> 4.3.0"
  s.add_dependency "devise_invitable", "~> 1.7.2"
  s.add_dependency "kaminari", "~> 1.0.1"
  s.add_dependency "paranoia", "~> 2.3.1"
  s.add_dependency "responders", "~> 2.4.0"
  s.add_dependency "validates", "~> 1.0.0"
end
