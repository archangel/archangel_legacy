# frozen_string_literal: true

require "thor"

require "archangel/commands/base_command"

module Archangel
  ##
  # Command line
  #
  module Commands
    ##
    # Generate Archangel theme
    #
    class ThemeCommand < BaseCommand
      source_root File.expand_path("templates/theme", __dir__)

      desc "Build an Archangel theme"
      argument :theme_name, type: :string, desc: "Theme name", default: "sample"

      ##
      # Generate theme
      #
      # Usage
      #   archangel theme [THEME_NAME]
      #   bundle exec bin/archangel theme [THEME_NAME]
      #
      def generate
        name_plugin
      end

      ##
      # Create theme directory
      #
      def create_plugin_directory
        empty_directory(theme_name)
      end

      ##
      # Create theme .gemspec file
      #
      def create_plugin_gemspec
        template("theme.gemspec", "#{theme_name}/#{theme_name}.gemspec")
      end

      ##
      # Copy common directories that are shared with extension generator
      #
      def copy_common_directories
        %w[spec].each do |dir|
          directory("../common/#{dir}", "#{theme_name}/#{dir}")
        end
      end

      ##
      # Copy theme directories and chmod bin scripts
      #
      def copy_plugin_directories
        %w[
          app bin lib
        ].each { |dir| directory(dir, "#{theme_name}/#{dir}") }

        chmod("#{theme_name}/bin/rails", 0o755)
      end

      ##
      # Copy common templates that are shared with extension generator
      #
      def copy_common_templates
        %w[
          .editorconfig .gitignore .rspec .rubocop.yml MIT-LICENSE
        ].each do |tpl|
          template("../common/#{tpl}", "#{theme_name}/#{tpl}")
        end
      end

      ##
      # Copy theme templates
      #
      def copy_plugin_templates
        %w[
          Gemfile Rakefile README.md
        ].each { |tpl| template(tpl, "#{theme_name}/#{tpl}") }
      end

      ##
      # Banner
      #
      # Say something nice
      #
      def banner
        puts %(

  ******************************************************************

    Your theme has been generated with a gemspec dependency on
    Archangel v#{archangel_version}

      #{random_compliment}

  ******************************************************************

        )
      end

      no_tasks do
        def class_name
          plugin_class_name(theme_name)
        end

        def name_plugin
          @theme_name = corrected_plugin_name
        end

        def theme_base_name
          theme_name.sub(/^archangel_/, "").sub(/_theme$/, "")
        end

        def corrected_plugin_name
          ext_name = theme_name.downcase
          ext_name = "archangel_#{ext_name}" unless ext_name =~ /^archangel_/
          ext_name = "#{ext_name}_theme" unless ext_name =~ /_theme$/

          Thor::Util.snake_case(ext_name)
        end
      end
    end
  end
end
