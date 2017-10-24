# frozen_string_literal: true

# Support files
%w[support helpers matchers shared_contexts].each do |type|
  Dir["#{File.dirname(__FILE__)}/#{type}/**/*.rb"].each do |f|
    load File.expand_path(f)
  end
end

# Factories
Dir["#{File.dirname(__FILE__)}/factories/**/archangel_*.rb"].each do |f|
  load File.expand_path(f)
end
