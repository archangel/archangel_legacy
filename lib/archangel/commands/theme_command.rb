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
      argument :extension_name, type: :string,
                                desc: "Theme name",
                                default: "sample"

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
        empty_directory(extension_name)
      end

      ##
      # Create extension .gemspec file
      #
      def create_common_plugin_gemspec
        template("../common/extension.gemspec",
                 "#{extension_name}/#{extension_name}.gemspec")
      end

      ##
      # Copy common directories that are shared with theme generator
      #
      def copy_common_directories
        %w[bin lib spec].each do |dir|
          directory("../common/#{dir}", "#{extension_name}/#{dir}")
        end

        chmod("#{extension_name}/bin/rails", 0o755)
      end

      ##
      # Copy common templates that are shared with theme generator
      #
      def copy_common_templates
        %w[
          .gitignore .rspec Gemfile MIT-LICENSE Rakefile
        ].each do |tpl|
          template("../common/#{tpl}", "#{extension_name}/#{tpl}")
        end
      end

      ##
      # Copy extension directories
      #
      def copy_plugin_directories
        %w[app].each { |dir| directory(dir, "#{extension_name}/#{dir}") }
      end

      ##
      # Copy extension templates
      #
      def copy_plugin_templates
        %w[README.md].each { |tpl| template(tpl, "#{extension_name}/#{tpl}") }
      end

      ##
      # Banner
      #
      # Say something nice
      #
      def banner
        say %(

  ******************************************************************

    Your theme has been generated with a gemspec dependency on
    Archangel v#{archangel_version}

      #{random_compliment}

  ******************************************************************

        )
      end

      no_tasks do
        def class_name
          plugin_class_name(extension_name)
        end

        def name_plugin
          @extension_name = corrected_plugin_name
        end

        def theme_base_name
          extension_name.sub(/^archangel_/, "").sub(/_theme$/, "")
        end

        def corrected_plugin_name
          ext_name = extension_name.downcase

          ext_name = "archangel_#{ext_name}" unless ext_name =~ /^archangel_/
          ext_name = "#{ext_name}_theme" unless ext_name =~ /_theme$/

          Thor::Util.snake_case(ext_name)
        end
      end
    end
  end
end
