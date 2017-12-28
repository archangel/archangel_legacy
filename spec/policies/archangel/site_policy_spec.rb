# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe SitePolicy, type: :policy do
    subject { described_class.new(user, record) }

    let(:user) { create(:user) }
    let(:record) { create(:site) }

    it { should permit(:show) }

    context "with `admin` role" do
      let(:user) { create(:user, :admin) }

      it { should permit(:update) }
      it { should permit(:edit) }
    end

    context "with `editor` role" do
      let(:user) { create(:user, :editor) }

      it { should_not permit(:update) }
      it { should_not permit(:edit) }
    end
  end
end
