# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("../lib", __FILE__)

require "archangel/version"

Gem::Specification.new do |s|
  s.name        = "archangel"
  s.version     = Archangel::VERSION
  s.authors     = ["dfreerksen"]
  s.email       = ["dfreerksen@gmail.com"]
  s.homepage    = "https://github.com/archangel/archangel"
  s.summary     = "Summary of Archangel."
  s.description = "Description of Archangel."
  s.license     = "MIT"

  s.files = Dir[
    "{app,config,db,lib}/**/*",
    "MIT-LICENSE",
    "Rakefile",
    "README.md"
  ]

  s.add_dependency "rails", "~> 5.1.4"

  s.add_dependency "responders", "~> 2.4.0"
end
