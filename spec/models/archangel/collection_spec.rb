# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe Collection, type: :model do
    context "callbacks" do
      it { expect(subject).to callback(:parameterize_slug).before(:validation) }

      it { expect(subject).to callback(:column_reset).after(:destroy) }
    end

    context "validations" do
      it { expect(subject).to validate_presence_of(:name) }
      it { expect(subject).to validate_presence_of(:slug) }

      it { expect(subject).to have_db_index(:slug).unique(true) }
    end

    context "associations" do
      it { expect(subject).to have_many(:entries) }
      it { expect(subject).to have_many(:fields) }
    end
  end
end
