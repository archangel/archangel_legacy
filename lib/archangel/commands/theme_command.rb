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
        prefix_name

        empty_directory theme_name

        copy_directories
        copy_files
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

      You look lovely today by the way.

  ******************************************************************

        )
      end

      no_tasks do
        def class_name
          Thor::Util.camel_case theme_name
        end

        def theme_base_name
          theme_name.sub(/^archangel_/, "").sub(/_theme$/, "")
        end
      end

      no_tasks do
        def prefix_name
          ext_name = theme_name.downcase
          ext_name = "archangel_#{ext_name}" unless ext_name =~ /^archangel_/
          ext_name = "#{ext_name}_theme" unless ext_name =~ /_theme$/

          @theme_name = Thor::Util.snake_case(ext_name)
        end

        def copy_directories
          %w[
            app bin lib spec
          ].each { |dir| directory(dir, "#{theme_name}/#{dir}") }

          chmod("#{theme_name}/bin/rails", 0o755)
        end

        def copy_files
          %w[
            .editorconfig .gitignore .rspec .rubocop.yml Gemfile MIT-LICENSE
            Rakefile README.md
          ].each { |tpl| template(tpl, "#{theme_name}/#{tpl}") }

          template("theme.gemspec", "#{theme_name}/#{theme_name}.gemspec")
        end
      end
    end
  end
end
