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
        def archangel_version
          Archangel.version[/(.*)\./, 1]
        end

        def random_compliment
        end
      end
    end
  end
end
