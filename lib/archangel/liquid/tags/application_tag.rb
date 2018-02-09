# frozen_string_literal: true

module Archangel
  module Liquid
    ##
    # Archangel custom Liquid tags
    #
    module Tags
      ##
      # Base helper class for Liquid
      #
      class ApplicationTag < ::Liquid::Tag
        include ::ActionView::Helpers::TagHelper
      end
    end
  end
end
