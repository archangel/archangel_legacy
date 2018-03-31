# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("lib", __dir__)

require "archangel/version"

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = "archangel"
  s.version     = Archangel.version
  s.authors     = ["David Freerksen"]
  s.email       = ["dfreerksen@gmail.com"]
  s.homepage    = "https://github.com/archangel/archangel"
  s.summary     = "Archangel is a Rails CMS"
  s.description = "Archangel is a Rails CMS"
  s.license     = "MIT"
  s.files       = `git ls-files`.split($ORS)

  s.required_ruby_version = ">= 2.2.9"

  s.add_dependency "jquery-rails", ">= 4.1.0"
  s.add_dependency "rails", "~> 5.1.4"
  s.add_dependency "sass-rails", ">= 5.0.0"
  s.add_dependency "uglifier", ">= 2.7"

  s.add_dependency "acts_as_list", "~> 0.9.10"
  s.add_dependency "acts_as_tree", "~> 2.7.0"
  s.add_dependency "anyway_config", "~> 1.2.0"
  s.add_dependency "bootstrap", "~> 4.0.0"
  s.add_dependency "bootstrap3-datetimepicker-rails", "~> 4.17.47"
  s.add_dependency "carrierwave", "~> 1.2.1"
  s.add_dependency "cocoon", "~> 1.2.11"
  s.add_dependency "date_validator", "~> 0.9.0"
  s.add_dependency "devise", "~> 4.4.0"
  s.add_dependency "devise_invitable", "~> 1.7.2"
  s.add_dependency "file_validators", "~> 2.1.0"
  s.add_dependency "font-awesome-rails", "~> 4.7.0"
  s.add_dependency "highline", "~> 1.7.10"
  s.add_dependency "jbuilder", "~> 2.7.0"
  s.add_dependency "kaminari", "~> 1.1.1"
  s.add_dependency "liquid", "~> 4.0.0"
  s.add_dependency "meta-tags", "~> 2.8.0"
  s.add_dependency "mini_magick", "~> 4.8.0"
  s.add_dependency "momentjs-rails", "~> 2.20.1"
  s.add_dependency "paranoia", "~> 2.4.0"
  s.add_dependency "popper_js", "~> 1.12.9"
  s.add_dependency "pundit", "~> 1.1.0"
  s.add_dependency "responders", "~> 2.4.0"
  s.add_dependency "selectize-rails", "~> 0.12.4"
  s.add_dependency "simple_form", "~> 3.5.0"
  s.add_dependency "summernote-rails", "~> 0.8.10"
  s.add_dependency "validates", "~> 1.0.0"
end
