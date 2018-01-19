# frozen_string_literal: true

module Archangel
  module Liquid
    module Tags
      ##
      # Collection custom tag for Liquid
      #
      # Example
      #   {% collection collection-name as articles %}
      #     <div>{{ article.title }}</div>
      #   {% endcollection %}
      #
      class CollectionTag < BaseTag
        ##
        # Render the Collection
        #
        # @param context [Object] the Liquid context
        # @return [String] the Collection
        #
        def render(context)
          [
            { title: "First item title" },
            { title: "Second item title" }
          ]
        end
      end
    end
  end
end

::Liquid::Template.register_tag("collection",
                                Archangel::Liquid::Tags::CollectionTag)
