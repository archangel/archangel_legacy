# frozen_string_literal: true

module Archangel
  module Liquid
    module Tags
      class CsrfMetaTagsTag < ::Liquid::Tag
        def render(context)
          context.registers[:view].csrf_meta_tags
        end
      end
    end
  end
end

::Liquid::Template.register_tag("csrf_meta_tags",
                                Archangel::Liquid::Tags::CsrfMetaTagsTag)
