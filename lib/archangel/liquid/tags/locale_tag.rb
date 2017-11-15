# frozen_string_literal: true

module Archangel
  module Liquid
    module Tags
      class LocaleTag < ::Liquid::Tag
        def render(context)
          context.registers[:view].locale
        end
      end
    end
  end
end

::Liquid::Template.register_tag "locale", Archangel::Liquid::Tags::LocaleTag
