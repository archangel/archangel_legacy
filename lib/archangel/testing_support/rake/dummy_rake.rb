# frozen_string_literal: true

unless defined?(Archangel::Generators::InstallGenerator)
  require "generators/archangel/install/install_generator"
end

require "generators/archangel/dummy/dummy_generator"

desc "Generates a dummy app for testing"
namespace :dummy do
  task :generate do |_t, _args|
    lib = ENV["LIB_NAME"].to_s

    require lib unless defined?(lib.camelize.constantize)

    ENV["RAILS_ENV"] = "test"

    Archangel::Generators::DummyGenerator.start [
      "--lib_name=#{lib}",
      "--quiet"
    ]

    Archangel::Generators::InstallGenerator.start [
      "--lib_name=#{lib}",
      "--auto-accept",
      "--migrate=false",
      "--seed=false",
      "--quiet"
    ]

    puts "Setting up dummy database..."
    system("bundle exec rake db:drop db:create db:migrate > #{File::NULL}")

    # puts "Precompiling assets..."
    # system("bundle exec rake assets:precompile > #{File::NULL}")

    unless lib == "archangel"
      begin
        require "generators/#{lib}/install/install_generator"

        puts "Running extension installation generator..."

        "#{lib.camelize}::Generators::InstallGenerator"
          .constantize
          .start(
            [
              "--auto-run-migrations",
              "--auto-accept",
              "--migrate",
              "--skip-seed",
              "--skip-turbolinks",
              "--route-path=#{lib}",
              "--quiet"
            ]
          )
      rescue LoadError
        puts "Skipping extension install. No generator to run..."
      end
    end
  end
end
