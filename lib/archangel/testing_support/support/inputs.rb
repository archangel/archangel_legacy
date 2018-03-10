# frozen_string_literal: true

module Archangel
  module TestingSupport
    ##
    # SimpleForm input meta type for testing
    #
    module InputExampleGroup
      extend ActiveSupport::Concern

      include RSpec::Rails::HelperExampleGroup

      def input_for(object, attribute_name, options = {})
        helper.simple_form_for object, url: "" do |form|
          form.input attribute_name, options
        end
      end
    end
  end
end

RSpec.configure do |config|
  config.include Archangel::TestingSupport::InputExampleGroup, type: :input
end
