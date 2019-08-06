# frozen_string_literal: true

module Archangel
  ##
  # Archangel engine
  #
  class Engine < ::Rails::Engine
    isolate_namespace Archangel
    engine_name :archangel

    require "responders"

    initializer "archangel.load_locales" do |app|
      Archangel::THEME_DIRECTORIES.each.each do |path|
        path ||= Rails.root

        full_path = "#{path}/app/themes/*/locales/**/*.yml"

        Dir.glob(full_path).each { |dir| app.config.i18n.load_paths << dir }
      end
    end

    initializer "archangel.assets_path" do |app|
      Archangel::THEME_DIRECTORIES.each.each do |path|
        path ||= Rails.root

        full_path = "#{path}/app/themes/*/assets/*"

        Dir.glob(full_path).each { |dir| app.config.assets.paths << dir }
      end
    end

    initializer "archangel.precompile" do |app|
      Archangel::THEME_DIRECTORIES.each.each do |path|
        path ||= Rails.root

        full_path = Pathname.new("#{path}/app/themes/*/assets/**/*")

        allowed_regex = %r{
          ([^/]+)
          /assets/(javascripts|stylesheets)/
          ([^/]+)
          /(auth|backend|frontend).(js|css)
        }x

        Dir.glob(full_path).each do |file|
          next unless File.file?(file)

          file_path = Pathname.new(file).relative_path_from(path).to_s

          if allowed_regex.match?(file_path)
            app.config.assets.precompile << file
          end
        end
      end
    end

    config.after_initialize do
      Rails.application.routes_reloader.reload!
    end

    config.action_controller.include_all_helpers = false

    config.generators do |gen|
      gen.test_framework :rspec,
                         fixtures: false,
                         view_specs: false,
                         helper_specs: true,
                         routing_specs: false,
                         controller_specs: true,
                         request_specs: true

      gen.fixture_replacement :factory_bot, dir: "spec/factories"
    end
  end
end
