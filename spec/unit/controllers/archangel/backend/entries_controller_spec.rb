# frozen_string_literal: true

require "rails_helper"

module Archangel
  module Backend
    RSpec.describe EntriesController, type: :controller do
      before { stub_authorization! }

      let(:site) { create(:site) }
      let(:collection) { create(:collection, site: site) }
      let(:field) { create(:field, collection: collection, slug: "slug") }

      describe "POST #sort" do
        let(:collection) { create(:collection) }
        let!(:field) do
          create(:field, collection: collection, slug: "slug")
        end

        it "assigns all resources as @entries" do
          entry_a = create(:entry,
                           collection: collection,
                           value: { slug: "first" })
          entry_b = create(:entry,
                           collection: collection,
                           value: { slug: "second" })

          params = {
            sort: {
              "0" => entry_a.id,
              "1" => entry_b.id
            }
          }

          post :sort, params: {
            collection_id: collection,
            collection_entry: params
          }

          expect(response).to have_http_status(:accepted)
        end
      end
    end
  end
end
