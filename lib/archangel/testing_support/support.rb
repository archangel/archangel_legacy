# frozen_string_literal: true

def uploader_test_image
  Archangel::Engine.root + "lib/archangel/testing_support/fixtures/image.gif"
end

def uploader_test_favicon
  Archangel::Engine.root + "lib/archangel/testing_support/fixtures/favicon.png"
end

def uploader_test_stylesheet
  Archangel::Engine.root +
    "lib/archangel/testing_support/fixtures/stylesheet.css"
end

# Support files
%w[context support helpers matchers shared_contexts].each do |type|
  Dir["#{File.dirname(__FILE__)}/#{type}/**/*.rb"].each do |f|
    load File.expand_path(f)
  end
end

# Factories
Dir["#{File.dirname(__FILE__)}/factories/**/archangel_*.rb"].each do |f|
  load File.expand_path(f)
end
