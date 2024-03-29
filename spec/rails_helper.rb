# frozen_string_literal: true

require "simplecov"

SimpleCov.start :rails do
  add_filter "dummy_generator.rb"
  add_filter "install_generator.rb"
  add_filter "lib/archangel/command"
  add_filter "lib/archangel/testing_support"
  add_filter "lib/generators/archangel/install/templates"
  add_filter "version.rb"

  add_group "Inputs", "app/inputs"
  add_group "Modules", "app/modules"
  add_group "Policies", "app/policies"
  add_group "Services", "app/services"
  add_group "Uploaders", "app/uploaders"
end

ENV["RAILS_ENV"] ||= "test"

begin
  require File.expand_path("dummy/config/environment", __dir__)
rescue LoadError
  puts "Could not load test application. Run `bundle exec rake dummy_app` first"
  exit
end

if Rails.env.production?
  abort("The Rails environment is running in production mode!")
end

require "spec_helper"

require "pry-byebug"
require "rspec/rails"

# Archangel test support files
require "archangel/testing_support/support"

# Local support files
Dir[Rails.root.join("../support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end
