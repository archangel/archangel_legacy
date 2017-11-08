# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe Page, type: :model do
    context "validations" do
      it { expect(subject).to validate_presence_of(:content) }
      it { expect(subject).to validate_presence_of(:slug) }
      it { expect(subject).to validate_presence_of(:title) }

      it { expect(subject).to allow_value(true).for(:homepage) }
      it { expect(subject).to allow_value(false).for(:homepage) }
      it { expect(subject).not_to allow_value(nil).for(:homepage) }

      it { expect(subject).to allow_value(nil).for(:published_at) }
      it { expect(subject).to allow_value(Time.current).for(:published_at) }
      it { expect(subject).not_to allow_value("invalid").for(:published_at) }

      it { expect(subject).to have_db_index(:path).unique(true) }
    end

    context "associations" do
      it { expect(subject).to belong_to(:parent) }
      it { expect(subject).to belong_to(:template) }
    end

    context "callbacks" do
      it { expect(subject).to callback(:parameterize_slug).before(:validation) }

      it { expect(subject).to callback(:build_page_path).before(:save) }

      it { expect(subject).to callback(:homepage_reset).after(:save) }

      it { expect(subject).to callback(:column_reset).after(:destroy) }
    end

    context "scopes" do
      context ".published" do
        it "returns all where published_at <= now" do
          page = create(:page)

          expect(Page.published.first).to eq(page)
        end
      end

      context ".unpublished" do
        it "returns all where published_at is nil" do
          page = create(:page, :unpublished)

          expect(Page.unpublished.first).to eq(page)
        end

        it "returns all where published_at is > now" do
          page = create(:page, :future)

          expect(Page.unpublished.first).to eq(page)
        end
      end

      context ".homepage" do
        it "returns all where homepage is true" do
          page = create(:page, :homepage)

          expect(Page.homepage.first).to eq(page)
        end
      end
    end

    context "#published?" do
      it "is published" do
        page = build(:page)

        expect(page.published?).to be_truthy
      end

      it "is published for the future" do
        page = build(:page, published_at: 1.week.from_now)

        expect(page.published?).to be_truthy
      end

      it "is not published" do
        page = build(:page, :unpublished)

        expect(page.published?).to be_falsey
      end
    end
  end
end
