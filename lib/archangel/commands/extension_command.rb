# frozen_string_literal: true

require "thor"

require "archangel/commands/base_command"

module Archangel
  ##
  # Command line
  #
  module Commands
    ##
    # Generate Archangel extension
    #
    class ExtensionCommand < BaseCommand
      source_root File.expand_path("templates/extension", __dir__)

      desc "Build an Archangel extension"
      argument :extension_name, type: :string,
                                desc: "Extension name",
                                default: "sample"

      ##
      # Generate extension
      #
      # Usage
      #   archangel extension [EXTENSION_NAME]
      #   bundle exec bin/archangel extension [EXTENSION_NAME]
      #
      def generate
        name_plugin
      end

      ##
      # Create extension directory
      #
      def create_plugin_directory
        empty_directory(extension_name)
      end

      ##
      # Create extension .gemspec file
      #
      def create_plugin_gemspec
        template("extension.gemspec",
                 "#{extension_name}/#{extension_name}.gemspec")
      end

      ##
      # Copy common directories that are shared with theme generator
      #
      def copy_common_directories
        %w[
          bin lib spec
        ].each do |dir|
          directory("../common/#{dir}", "#{extension_name}/#{dir}")
        end

        chmod("#{extension_name}/bin/rails", 0o755)
      end

      ##
      # Copy extension directories and chmod bin scripts
      #
      def copy_plugin_directories
        %w[
          config lib
        ].each { |dir| directory(dir, "#{extension_name}/#{dir}") }
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
      # Copy extension templates
      #
      def copy_plugin_templates
        %w[
          README.md
        ].each { |tpl| template(tpl, "#{extension_name}/#{tpl}") }
      end

      ##
      # Banner
      #
      # Say something nice
      #
      def banner
        say %(

  ******************************************************************

    Your extension has been generated with a gemspec dependency on
    Archangel ~> v#{archangel_version}

      I have a feeling you're about to build something amazing.

  ******************************************************************

        )
      end

      no_tasks do
        def name_plugin
          @extension_name = corrected_plugin_name
        end

        def corrected_plugin_name
          ext_name = extension_name.downcase

          ext_name = "archangel_#{ext_name}" unless ext_name =~ /^archangel_/

          Thor::Util.snake_case(ext_name)
        end
      end
    end
  end
end
