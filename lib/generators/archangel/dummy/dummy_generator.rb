# frozen_string_literal: true

require "rails/generators"
require "rails/generators/rails/app/app_generator"
require "active_support/core_ext/hash"

module Archangel
  ##
  # Archangel generator
  #
  module Generators
    ##
    # Archangel dummy application generator for testing
    #
    class DummyGenerator < Rails::Generators::Base
      desc "Creates blank Rails application, installs Archangel"

      class_option :lib_name, default: "", desc: "Library name"
      class_option :database, default: "sqlite",
                              desc: "Type of database to use in dummy app."

      source_root File.expand_path("templates", __dir__)

      ##
      # Database type
      #
      attr_reader :database

      ##
      # Library name
      #
      attr_reader :lib_name

      ##
      # Rails flags available to be passed with generator
      #
      PASSTHROUGH_OPTIONS = %i[
        skip_active_record skip_javascript database javascript quiet pretend
        force skip
      ].freeze

      ##
      # Do not allowing running the generator within the application
      #
      def prevent_application_dummy
        return unless Rails.try(:root) && !Rails.root.blank?

        abort "Dummy generator cannot be run outside Archangel extension."
      end

      ##
      # Remove dummy directory
      #
      def clean_up
        remove_directory_if_exists(dummy_path)
      end

      ##
      # Generate new dummy directory
      #
      def generate_dummy
        opts = {}.merge(options).slice(*PASSTHROUGH_OPTIONS)

        opts[:database] = "sqlite3" if opts[:database].blank?
        opts[:force] = true
        opts[:skip_bundle] = true
        opts[:skip_git] = true
        opts[:old_style_hash] = false
        opts[:skip_turbolinks] = true
        opts[:skip_bootsnap] = true

        puts "Generating dummy Rails application..."

        invoke Rails::Generators::AppGenerator,
               [File.expand_path(dummy_path, destination_root)],
               opts
      end

      ##
      # Copy dummy application files
      #
      def copy_dummy_config
        @lib_name = options[:lib_name]
        @database = options[:database]

        %w[config/database.yml].each do |tpl|
          template tpl, "#{dummy_path}/#{tpl}", force: true
        end
      end

      ##
      # Insert config options in test environment
      #
      def test_default_url
        insert_into_file("#{dummy_path}/config/environments/test.rb",
                         after: "Rails.application.configure do") do
          <<-DEFAULT_URL.strip_heredoc.indent(2)

            config.action_mailer.default_url_options = {
              host: "localhost",
              port: 3000
            }

            config.action_view.raise_on_missing_translations = true

          DEFAULT_URL
        end
      end

      ##
      # Remove unnecessary generated files
      #
      def dummy_cleanup
        inside dummy_path do
          paths = %w[.gitignore db/seeds.rb Gemfile lib/tasks public/robots.txt
                     spec test vendor]

          paths.each { |path| remove_file path }
        end
      end

      protected

      def remove_directory_if_exists(path)
        remove_dir(path) if File.directory?(path)
      end

      def inject_require_for(requirement)
        insert_into_file("config/application.rb",
                         before: /require "#{@lib_name}"/,
                         verbose: true) do
          <<-APP_CONFIG.strip_heredoc.indent(2)

            begin
              require "#{requirement}"
            rescue LoadError
              # #{requirement} is not available.
            end

          APP_CONFIG
        end
      end

      def dummy_path
        ENV["DUMMY_PATH"] || "spec/dummy"
      end
    end
  end
end
