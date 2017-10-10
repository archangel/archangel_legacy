# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe "WYSIWYG custom input for simple_form", type: :input do
    before do
      concat input_for(:foo, :input_field, as: :wysiwyg)
    end

    it "applies class to field" do
      assert_select "textarea.wysiwyg", count: 1
    end
  end
end
