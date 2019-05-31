# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe Page, type: :model do
    context "callbacks" do
      it { is_expected.to callback(:parameterize_slug).before(:validation) }

      it { is_expected.to callback(:build_page_permalink).before(:save) }

      it { is_expected.to callback(:homepage_reset).after(:save) }

      it { is_expected.to callback(:column_reset).after(:destroy) }
    end

    context "validations" do
      it { is_expected.to validate_presence_of(:content) }
      it { is_expected.to validate_presence_of(:slug) }
      it { is_expected.to validate_presence_of(:title) }

      it { is_expected.to allow_value("{{ foo }}").for(:content) }

      it { is_expected.to allow_value(true).for(:homepage) }
      it { is_expected.to allow_value(1).for(:homepage) }
      it { is_expected.to allow_value(false).for(:homepage) }
      it { is_expected.to allow_value(0).for(:homepage) }

      it { is_expected.to_not allow_value(nil).for(:homepage) }

      it { is_expected.to allow_value(nil).for(:published_at) }
      it { is_expected.to allow_value(Time.current).for(:published_at) }

      it { is_expected.to_not allow_value("invalid").for(:published_at) }

      it "has a unique permalink scoped to Site" do
        resource = build(:page)

        expect(resource).to(
          validate_uniqueness_of(:permalink).scoped_to(:site_id)
        )
      end

      it "has a unique slug scoped to Parent and Site" do
        resource = build(:page, :with_parent)

        expect(resource).to(
          validate_uniqueness_of(:slug).scoped_to(%i[parent_id site_id])
                                       .case_insensitive
        )
      end

      it { is_expected.to allow_value("{{ foo }}").for(:content) }
      it { is_expected.to_not allow_value("{{ foo }").for(:content) }
    end

    context "associations" do
      it do
        is_expected.to belong_to(:design).conditions(partial: false).optional
      end
      it { is_expected.to belong_to(:site) }
      it do
        is_expected.to belong_to(:parent).class_name("Archangel::Page").optional
      end

      it { is_expected.to have_many(:metatags) }
    end

    context "scopes" do
      context ".available" do
        it "returns all where published_at <= now" do
          page = create(:page)

          expect(described_class.available.first).to eq(page)
        end

        it "returns all where published_at <= now not in the future" do
          page = create(:page, :future)

          expect(described_class.available.first).to_not eq(page)
        end
      end

      context ".published" do
        it "returns all where published_at <= now" do
          page = create(:page)

          expect(described_class.published.first).to eq(page)
        end

        it "returns all where published_at <= now in the future" do
          page = create(:page, :future)

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

    context ".available?" do
      it "is available when published in the past" do
        page = build(:page, published_at: 1.week.ago)

        expect(page.available?).to be_truthy
      end

      it "is unavailable when published in the future" do
        page = build(:page, published_at: 1.week.from_now)

        expect(page.available?).to be_falsey
      end

      it "is unavailable not published" do
        page = build(:page, :unpublished)

        expect(page.available?).to be_falsey
      end
    end

    context "#to_liquid" do
      it "returns a Liquid object" do
        resource = build(:page)

        expect(resource.to_liquid).to be_a(Archangel::Liquid::Drops::PageDrop)
      end
    end

    context "#column_reset" do
      it "resets `slug` to `slug` + current time" do
        resource = create(:page)

        slug = resource.slug

        resource.destroy!

        expect(resource.slug).to eq "#{Time.current.to_i}_#{slug}"
      end
    end
  end
end