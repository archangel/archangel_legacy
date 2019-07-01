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
    class BaseCommand < Thor::Group
      include Thor::Actions

      no_tasks do
        def class_name
          plugin_class_name(extension_name)
        end

        def plugin_class_name(plugin_name)
          Thor::Util.camel_case(plugin_name)
        end

        def archangel_version
          Archangel.version[/(.*)\./, 1]
        end
      end
    end
  end
end
