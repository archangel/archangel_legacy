# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Backend - Pages", type: :request do
  before { stub_authorization!(create(:user)) }

  describe "POST /backend/assets/wysiwyg(.json) (#wysiwyg)" do
    describe "with valid attributes" do
      it "responds successully" do
        post "/backend/assets/wysiwyg",
             headers: { accept: "application/json" },
             params: { file: fixture_file_upload(uploader_test_image) }

        expect(response.content_type).to eq("application/json")
        expect(response).to have_http_status(:ok)

        expect(response).to match_response_schema("backend/assets/wysiwyg_url")

        expect(json_response[:success]).to eq(true)
        expect(json_response[:url])
          .to start_with("/uploads/archangel/asset/file/")
      end

      it "responds with error" do
        post "/backend/assets/wysiwyg",
             headers: { accept: "application/json" },
             params: { file: fixture_file_upload(uploader_test_stylesheet) }

        expect(response.content_type).to eq("application/json")
        expect(response).to have_http_status(:ok)

        expect(response)
          .to match_response_schema("backend/assets/wysiwyg_error")

        expect(json_response[:success]).to eq(false)
        expect(json_response[:error]).to include(
          "You are not allowed to upload \"css\" files, allowed types: " \
          "gif, jpeg, jpg, png"
        )
      end
    end
  end
end
