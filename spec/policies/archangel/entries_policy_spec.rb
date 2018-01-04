# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe EntryPolicy, type: :policy do
    subject { described_class.new(user, record) }

    let(:user) { create(:user) }
    let(:record) { create(:entry) }

    it { should permit(:index) }
    it { should permit(:show) }
    it { should permit(:create) }
    it { should permit(:new) }
    it { should permit(:update) }
    it { should permit(:edit) }
    it { should permit(:destroy) }

    it { should permit(:sort) }
  end
end
