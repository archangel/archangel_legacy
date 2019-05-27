# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe "Language custom input for simple_form", type: :input do
    before { concat input_for(:foo, :select_field, as: :language) }

    it "applies class to field" do
      assert_select "select.language", count: 1
    end

    it "has options" do
      assert_select "option", count: Archangel::LANGUAGES.count
    end
  end
end
