# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Backend - Entries (JSON)", type: :request do
  before { stub_authorization! }

  describe "POST /backend/collections/:id/entries/sort (#sort)" do
    let(:collection) { create(:collection, slug: "amazing") }

    let(:entry_a) do
      create(:entry, collection: collection, value: { slug: "first" })
    end
    let(:entry_b) do
      create(:entry, collection: collection, value: { slug: "second" })
    end

    before { create(:field, collection: collection, slug: "slug") }

    describe "with valid attributes" do
      it "returns 202 status code" do
        post "/backend/collections/amazing/entries/sort",
             headers: { accept: "application/json" },
             params: { collection_entry: { sort: {
               id: entry_a.id, position: "1"
             } } }

        expect(response).to have_http_status(:accepted)
      end
    end
  end
end
