# frozen_string_literal: true

require "selenium-webdriver"
require "webdrivers"

RSpec.configure do |config|
  config.before(:each, type: :feature) do
    Capybara.javascript_driver = :selenium_chrome_headless
  end

  config.before(:each, type: :feature, js: true) do
    config.include Capybara::DSL

    Capybara.default_host = "http://www.example.com"
    Capybara.server = :webrick
  end
end
