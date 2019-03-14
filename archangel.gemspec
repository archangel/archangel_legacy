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
  s.summary     = "Archangel CMS"
  s.description = "Archangel is a Rails CMS"
  s.license     = "MIT"
  s.metadata    = {
    "bug_tracker_uri" => "https://github.com/archangel/archangel/issues",
    "documentation_uri" =>
      "https://www.rubydoc.info/github/archangel/archangel/master",
    "homepage_uri" => "https://github.com/archangel/archangel",
    "source_code_uri" => "https://github.com/archangel/archangel",
    "wiki_uri" => "https://github.com/archangel/archangel/wiki"
  }
  s.files       = `git ls-files -z`.split("\x0")
  s.executables = ["archangel"]

  s.required_ruby_version = ">= 2.3.8"

  s.add_dependency "jquery-rails", "~> 4.1", ">= 4.1.0"
  s.add_dependency "rails", "~> 5.1", ">= 5.1.4"
  s.add_dependency "thor", "~> 0.19", ">= 0.19.0"

  s.add_dependency "activerecord-typedstore", "~> 1.2"
  s.add_dependency "acts_as_list", "~> 0.9"
  s.add_dependency "acts_as_tree", "~> 2.8"
  s.add_dependency "anyway_config", "~> 1.4"
  s.add_dependency "carrierwave", "~> 1.2"
  s.add_dependency "cocoon", "~> 1.2"
  s.add_dependency "date_validator", "~> 0.9"
  s.add_dependency "devise", "~> 4.6"
  s.add_dependency "devise_invitable", "~> 1.7"
  s.add_dependency "file_validators", "~> 2.3"
  s.add_dependency "highline", "~> 2.0"
  s.add_dependency "jbuilder", "~> 2.7"
  s.add_dependency "kaminari", "~> 1.1"
  s.add_dependency "liquid", "~> 4.0"
  s.add_dependency "meta-tags", "~> 2.10"
  s.add_dependency "mini_magick", "~> 4.9"
  s.add_dependency "momentjs-rails", "~> 2.20"
  s.add_dependency "paranoia", "~> 2.4"
  s.add_dependency "popper_js", "~> 1.14"
  s.add_dependency "pundit", "~> 2.0"
  s.add_dependency "responders", "~> 2.4"
  s.add_dependency "sass-rails", "~> 5.0"
  s.add_dependency "selectize-rails", "~> 0.12"
  s.add_dependency "simple_form", "~> 4.0"
  s.add_dependency "validates", "~> 1.0"
end
