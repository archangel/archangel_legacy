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
      class BaseTag < ::Liquid::Tag
        protected

        def clean_param(key)
          key.strip.gsub(/\s|"|'/, "")
        end

        def key_with_params(params)
          matches = /\s*(["|'])?([\w-]+\.[\w]+)\1?\s*(.*)/.match(params)

          [matches[2], attribute_string_to_hash(matches[3])]
        end

        def attribute_string_to_hash(attribute_string)
          matches = attribute_string.scan(/(\S+)\s*=\s*(["|'])?([^'"]+)\2?/)

          matches.each_with_object({}) do |match, hash|
            hash[match[0]] = match[2]
          end
        end
      end
    end
  end
end
