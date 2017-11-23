# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe "Field classification custom input for simple_form",
                 type: :input do
    before { concat input_for(:foo, :select_field, as: :field_classification) }

    it "applies class to field" do
      assert_select "select.field_classification", count: 1
    end

    it "has options" do
      assert_select "option", count: Archangel::Field::CLASSIFICATIONS.count
      assert_select "select[multiple=multiple]", count: 0
    end
  end
end
