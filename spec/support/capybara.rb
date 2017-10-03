# frozen_string_literal: true

require "capybara/rails"
require "capybara/rspec"

require "capybara/poltergeist"

Capybara.javascript_driver = :poltergeist
Capybara.default_max_wait_time = 10
