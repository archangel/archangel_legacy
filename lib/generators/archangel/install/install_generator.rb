# frozen_string_literal: true

require "active_support/core_ext/string/indent"
require "rails/generators"
require "highline/import"

module Archangel
  module Generators
    ##
    # Archangel install generator
    #
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      class_option :admin_email, type: :string, desc: "Admin email address"
      class_option :admin_name, type: :string, desc: "Admin name"
      class_option :admin_password, type: :string, desc: "Admin password"
      class_option :admin_username, type: :string, desc: "Admin username"

      class_option :migrate, type: :boolean,
                             default: true,
                             desc: "Run database migrations"
      class_option :quiet, type: :boolean,
                           default: false,
                           desc: "Silence is golden"
      class_option :route_path, type: :string, default: "", desc: "Root path"
      class_option :seed, type: :boolean, default: false, desc: "Seed database"

      desc "Install Archangel for the first time"

      ##
      # Do not allowing running the generator within the gem
      #
      def prevent_nested_install
        return unless Rails.respond_to?(:root) && Rails.root.nil?

        abort "Install generator cannot be run inside Archangel extension."
      end

      ##
      # Copy files
      #
      def add_files
        say_quietly "Copying files..."

        %w[
          .env.sample
          config/initializers/carrierwave.rb
          config/initializers/devise.rb
          config/archangel.yml
        ].each do |file|
          template file
        end
      end

      ##
      # Copy vendor files for Archangel extensions
      #
      def add_vendor_files
        say_quietly "Copying files..."

        %w[auth backend frontend].each do |section|
          template "vendor/assets/javascripts/archangel/#{section}.js"
          template "vendor/assets/stylesheets/archangel/#{section}.css"
        end
      end

      ##
      # Disallow backend indexing in robots.txt
      #
      def disallow_robots
        return unless File.exist? "public/robots.txt"

        append_file "public/robots.txt", <<-ROBOTS.strip_heredoc
          User-agent: *
          Disallow: /backend
        ROBOTS
      end

      ##
      # Create seed file if needed
      #
      def create_seeds_file
        return unless options[:seed]
        return if File.exist?(File.join(destination_root, "db", "seeds.rb"))

        say_quietly "Creating db/seeds.rb file..."

        create_file "db/seeds.rb"
      end

      ##
      # Append Archangel seeds to seed file
      #
      def add_archangel_seed
        return unless options[:seed]

        say_quietly "Seeding local seeds.rb..."

        append_file "db/seeds.rb", <<-SEEDS.strip_heredoc
          # Archangel seed data
          Archangel::Engine.load_seed

        SEEDS
      end

      ##
      # Install Archangel migrations
      #
      def install_migrations
        say_quietly "Installing migrations..."

        silence_warnings { rake "railties:install:migrations" }
      end

      ##
      # Create database is needed
      #
      def create_database
        say_quietly "Creating database..."

        silence_warnings { rake "db:create" }
      end

      ##
      # Run Archangel migrations
      #
      def run_migrations
        if options[:migrate]
          say_quietly "Running migrations..."

          silence_warnings { rake "db:migrate" }
        else
          say_quietly "Skipping migrations. Run `rake db:migrate` yourself."
        end
      end

      ##
      # Seed database
      #
      def seed_database
        if options[:migrate] && options[:seed]
          say_quietly "Inseminating..."

          silence_warnings { rake "db:seed #{rake_seed_options}" }
        else
          say_quietly "Skipping seed data. Run `rake db:seed` yourself."
        end
      end

      ##
      # Insert Archangel routes
      #
      def insert_routes
        say_quietly "Adding Archangel routes..."

        insert_into_file(File.join("config", "routes.rb"),
                         after: "Rails.application.routes.draw do\n") do
          <<-ROUTES.strip_heredoc.indent(2)
            # This mounts Archangel's routes at the root of your application. If you would
            # like to change where the engine is mounted, simply change the :at option to
            # reflect your needs.
            #
            mount Archangel::Engine, at: "/#{options[:route_path]}"

          ROUTES
        end

        say_quietly "Your application's config/routes.rb has been updated."
      end

      ##
      # After install message
      #
      def banner
        say_quietly "*" * 80
        say_quietly "  Done, sir! Done! Archangel has been installed!"
      end

      protected

      no_tasks do
        def rake_seed_options
          fields = %w[admin_email admin_name admin_password admin_username]

          fields.map do |field|
            field_option = options[field.to_sym]

            "#{field.upcase}=#{field_option}" unless field_option.blank?
          end.compact.join(" ")
        end

        def say_quietly(message)
          puts message unless options[:quiet]
        end
      end
    end
  end
end
