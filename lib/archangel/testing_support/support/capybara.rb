# frozen_string_literal: true

require "capybara/poltergeist"
require "capybara/rails"
require "capybara/rspec"
require "selenium-webdriver"

Capybara.register_driver :headless_firefox do |app|
  options = Selenium::WebDriver::Firefox::Options.new
  options.add_argument("--headless")

  Capybara::Selenium::Driver.new(app, browser: :firefox, options: options)
end

Capybara.javascript_driver = :headless_firefox
Capybara.default_max_wait_time = 10

RSpec.configure do |config|
  config.before(:each, type: :feature, js: true) do
    Capybara.current_driver = :headless_firefox
    Capybara.server = :webrick
  end

  config.after(:each, type: :feature) do
    Capybara.use_default_driver
  end
end
