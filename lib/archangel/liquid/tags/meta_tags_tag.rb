# frozen_string_literal: true

require "meta-tags"

module Archangel
  module Liquid
    module Tags
      class MetaTagsTag < ::Liquid::Tag
        def render(context)
          context.registers[:view].display_meta_tags
        end
      end
    end
  end
end

::Liquid::Template.register_tag("meta_tags",
                                Archangel::Liquid::Tags::MetaTagsTag)
