# frozen_string_literal: true

require "thor"

module Archangel
  ##
  # Command line
  #
  module Commands
    ##
    # Generate Archangel extension
    #
    class ExtensionCommand < Thor::Group
      include Thor::Actions

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
        prefix_name

        empty_directory extension_name

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

    Your extension has been generated with a gemspec dependency on
    Archangel v#{archangel_version}

      You look lovely today by the way.

  ******************************************************************

        )
      end

      no_tasks do
        def class_name
          Thor::Util.camel_case extension_name
        end

        def archangel_version
          Archangel.version[/(.*)\./, 1]
        end
      end

      no_tasks do
        def prefix_name
          ext_name = extension_name.downcase
          ext_name = "archangel_#{ext_name}" unless ext_name =~ /^archangel_/

          @extension_name = Thor::Util.snake_case(ext_name)
        end

        def copy_directories
          %w[
            app bin config lib spec
          ].each { |dir| directory(dir, "#{extension_name}/#{dir}") }

          chmod("#{extension_name}/bin/rails", 0o755)
        end

        def copy_files
          %w[
            .editorconfig .gitignore .rspec .rubocop.yml Gemfile MIT-LICENSE
            Rakefile README.md
          ].each { |tpl| template(tpl, "#{extension_name}/#{tpl}") }

          template("extension.gemspec",
                   "#{extension_name}/#{extension_name}.gemspec")
        end
      end
    end
  end
end
