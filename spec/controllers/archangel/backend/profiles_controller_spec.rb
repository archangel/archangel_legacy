# frozen_string_literal: true

require "rails_helper"

module Archangel
  module Backend
    RSpec.describe ProfilesController, type: :controller do
      before { stub_authorization! profile }

      let(:profile) { create(:user) }

      describe "GET #show" do
        it "assigns the current user as @profile" do
          get :show

          expect(assigns(:profile)).to eq(profile)
        end

        it "uses default avatar for profile" do
          get :show

          expect(profile.avatar.url).to(
            include("/assets/archangel/fallback/avatar")
          )
        end
      end

      describe "PUT #update" do
        context "with avatar upload" do
          let(:attributes) do
            {
              avatar: fixture_file_upload(uploader_test_image)
            }
          end

          it "has avatar for @user" do
            put :update, params: { profile: attributes }

            expect(profile.avatar.url).to(
              include("/uploads/archangel/user/avatar")
            )
          end
        end
      end

      describe "DELETE #destroy" do
        it "destroys the current user" do
          expect { delete :destroy }.to change(User, :count).by(-1)
        end

        it "redirects to the root" do
          delete :destroy

          expect(response).to redirect_to(backend_root_path)
        end
      end
    end
  end
end
