# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("lib", __dir__)

require "<%= extension_name %>/version"

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = "<%= extension_name %>"
  s.version     = <%= class_name %>::VERSION
  s.authors     = ["Your Name"]
  s.homepage    = "https://github.com/USERNAME/<%= extension_name %>"
  s.summary     = "TODO: Summary of <%= class_name %>."
  s.description = "TODO: Description of <%= class_name %>."
  s.license     = "MIT"

  s.files = Dir[
    "{app,config,db,lib}/**/*",
    "MIT-LICENSE",
    "Rakefile",
    "README.md"
  ]

  s.add_dependency "archangel", "< 1.0"
end
