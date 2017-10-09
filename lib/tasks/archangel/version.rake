# frozen_string_literal: true

namespace :archangel do
  desc "Current Archangel version"
  task :version do
    puts "Archangel #{Archangel::VERSION}"
  end
end
