# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe "Time picker custom input for simple_form", type: :input do
    before do
      concat input_for(:foo, :input_field, as: :time_picker)
    end

    it "applies class to field" do
      assert_select "input.timepicker", count: 1
    end

    it "includes group icon" do
      assert_select "span.glyphicon.glyphicon-timestamp", count: 1
    end
  end
end
