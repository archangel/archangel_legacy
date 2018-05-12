# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe Page, type: :model do
    context "callbacks" do
      it { is_expected.to callback(:parameterize_slug).before(:validation) }

      it { is_expected.to callback(:build_page_path).before(:save) }

      it { is_expected.to callback(:homepage_reset).after(:save) }

      it { is_expected.to callback(:column_reset).after(:destroy) }
    end

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

      it { expect(subject).to allow_value("{{ foo }}").for(:content) }
      it { expect(subject).not_to allow_value("{{ foo }").for(:content) }
    end

    context "associations" do
      it { expect(subject).to belong_to(:parent) }
      it { expect(subject).to belong_to(:site) }
      it { expect(subject).to belong_to(:template) }
    end

    context "scopes" do
      context ".published" do
        it "returns all where published_at <= now" do
          page = create(:page)

          expect(described_class.published.first).to eq(page)
        end
      end

      context ".unpublished" do
        it "returns all where published_at is nil" do
          page = create(:page, :unpublished)

          expect(described_class.unpublished.first).to eq(page)
        end

        it "returns all where published_at is > now" do
          page = create(:page, :future)

          expect(described_class.unpublished.first).to eq(page)
        end
      end

      context ".homepage" do
        it "returns all where homepage is true" do
          page = create(:page, :homepage)

          expect(described_class.homepage.first).to eq(page)
        end
      end
    end

    context ".published?" do
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

    context "#to_liquid" do
      it "returns a Liquid object" do
        resource = build(:page)

        expect(resource.to_liquid).to be_a(Archangel::Liquid::Drops::PageDrop)
      end
    end

    context "#column_reset" do
      before { ::Timecop.freeze }
      after { ::Timecop.return }

      it "resets `slug` to `slug` + current time" do
        resource = create(:page)

        slug = resource.slug

        resource.destroy!

        expect(resource.slug).to eq "#{Time.current.to_i}_#{slug}"
      end
    end
  end
end
