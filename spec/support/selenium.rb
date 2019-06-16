# frozen_string_literal: true

require "webdrivers"

Capybara.register_driver :chrome do |app|
  Selenium::WebDriver.logger.level = :error

  options = Selenium::WebDriver::Chrome::Options.new(
    args: %w[headless disable-gpu window-size=1920,1080],
    log_level: :error
  )
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

RSpec.configure do |config|
  config.before(:each, type: :feature) do
    Capybara.javascript_driver = :chrome
  end

  config.before(:each, type: :feature, js: true) do
    config.include Capybara::DSL

    Capybara.default_host = "http://www.example.com"
    Capybara.server = :webrick
  end
end
