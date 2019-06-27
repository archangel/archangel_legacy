# frozen_string_literal: true

RSpec.configure do |config|
  config.after(:each, type: :feature) do |example|
    missing_translations =
      page.body.scan(/translation missing: #{I18n.locale}\.(.*?)[\s<\"&]/)

    if missing_translations.any?
      puts "Found missing translations: #{missing_translations.inspect}"
      puts "In spec: #{example.location}"
    end
  end
end
