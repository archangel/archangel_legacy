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
        def plugin_class_name(plugin_name)
          Thor::Util.camel_case(plugin_name)
        end

        def archangel_version
          Archangel.version[/(.*)\./, 1]
        end

        def random_compliment
          [
            "You look lovely today by the way.",
            "I have a feeling you're about to build something amazing.",
            "Of all the people in the world, you're my favorite."
          ].sample
        end
      end
    end
  end
end
