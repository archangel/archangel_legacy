# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Backend - Pages", type: :request do
  before { stub_authorization!(create(:user)) }

  describe "POST /backend/assets/wysiwyg(.json) (#wysiwyg)" do
    describe "with valid attributes" do
      it "responds with 200 status" do
        post "/backend/assets/wysiwyg",
             headers: { accept: "application/json" },
             params: { file: fixture_file_upload(uploader_test_image) }

        expect(response).to have_http_status(:ok)
      end

      it "responds with JSON schema" do
        post "/backend/assets/wysiwyg",
             headers: { accept: "application/json" },
             params: { file: fixture_file_upload(uploader_test_image) }

        expect(response).to match_response_schema("backend/assets/wysiwyg_url")
      end

      it "responds with success:true JSON node" do
        post "/backend/assets/wysiwyg",
             headers: { accept: "application/json" },
             params: { file: fixture_file_upload(uploader_test_image) }

        expect(json_response[:success]).to eq(true)
      end

      it "responds with url:string JSON node" do
        post "/backend/assets/wysiwyg",
             headers: { accept: "application/json" },
             params: { file: fixture_file_upload(uploader_test_image) }

        expect(json_response[:url])
          .to start_with("/uploads/archangel/asset/file/")
      end
    end

    describe "with invalid attributes" do
      it "responds with 200 status" do
        post "/backend/assets/wysiwyg",
             headers: { accept: "application/json" },
             params: { file: fixture_file_upload(uploader_test_stylesheet) }

        expect(response).to have_http_status(:ok)
      end

      it "responds with error JSON schema" do
        post "/backend/assets/wysiwyg",
             headers: { accept: "application/json" },
             params: { file: fixture_file_upload(uploader_test_stylesheet) }

        expect(response)
          .to match_response_schema("backend/assets/wysiwyg_error")
      end

      it "responds with success:false JSON node" do
        post "/backend/assets/wysiwyg",
             headers: { accept: "application/json" },
             params: { file: fixture_file_upload(uploader_test_stylesheet) }

        expect(json_response[:success]).to eq(false)
      end

      it "responds with error:string JSON node" do
        post "/backend/assets/wysiwyg",
             headers: { accept: "application/json" },
             params: { file: fixture_file_upload(uploader_test_stylesheet) }

        expected_error = "You are not allowed to upload \"css\" files"

        expect(json_response[:error]).to include(expected_error)
      end
    end
  end
end
