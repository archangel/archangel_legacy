# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe SitePolicy, type: :policy do
    subject { described_class.new(user, record) }

    let(:record) { create(:site) }

    context "with `admin` role" do
      let(:user) { create(:user, :admin) }

      it { is_expected.to permit(:show) }
      it { is_expected.to permit(:update) }
      it { is_expected.to permit(:edit) }

      it { is_expected.to permit(:sample) }
    end

    context "with `editor` role" do
      let(:user) { create(:user, :editor) }

      it { is_expected.to permit(:show) }

      it { is_expected.to permit(:sample) }

      it { is_expected.to_not permit(:update) }
      it { is_expected.to_not permit(:edit) }
    end
  end
end
