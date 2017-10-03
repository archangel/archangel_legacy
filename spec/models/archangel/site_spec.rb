# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe Site, type: :model do
    describe "ActiveModel validations" do
      it { expect(subject).to validate_presence_of(:name) }
    end
  end
end
