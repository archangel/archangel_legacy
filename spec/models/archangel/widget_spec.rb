# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe Widget, type: :model do
    context "callbacks" do
      it { expect(subject).to callback(:parameterize_slug).before(:validation) }

      it { expect(subject).to callback(:column_reset).after(:destroy) }
    end

    context "validations" do
      it { expect(subject).to validate_presence_of(:content) }
      it { expect(subject).to validate_presence_of(:name) }
      it { expect(subject).to validate_presence_of(:slug) }

      it { expect(subject).to have_db_index(:slug).unique(true) }

      it { expect(subject).to allow_value("{{ foo }}").for(:content) }
      it { expect(subject).not_to allow_value("{{ foo }").for(:content) }
    end

    context "associations" do
      it { expect(subject).to belong_to(:site) }
      it { expect(subject).to belong_to(:template) }
    end
  end
end
