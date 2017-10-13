# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe "Date picker custom input for simple_form", type: :input do
    before do
      concat input_for(:foo, :input_field, as: :date_picker)
    end

    it "applies class to field" do
      assert_select "input.datepicker", count: 1
    end
  end
end
