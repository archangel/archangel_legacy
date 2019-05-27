# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe "META Keywords custom input for simple_form", type: :input do
    before { concat input_for(:foo, :select_field, as: :meta_keywords) }

    it "applies class to field" do
      assert_select "input.meta_keywords", count: 1
    end
  end
end
