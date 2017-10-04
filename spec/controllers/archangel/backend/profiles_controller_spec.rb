# frozen_string_literal: true

require "rails_helper"

module Archangel
  module Backend
    RSpec.describe ProfilesController, type: :controller do
      before { stub_authorization! profile }

      let!(:profile) { create(:user) }

      describe "GET #show" do
        it "assigns the current user as @profile" do
          get :show

          expect(assigns(:profile)).to eq(profile)
        end

        xit "has default avatar for profile" do
          get :show

          expect(profile.avatar.url).to(
            include("/assets/archangel/avatar")
          )
        end
      end

      describe "GET #edit" do
        it "assigns the current user as @profile" do
          get :edit

          expect(assigns(:profile)).to eq(profile)
        end
      end

      describe "PUT #update" do
        xcontext "with avatar upload" do
          let(:attributes) do
            {
              avatar: fixture_file_upload(uploader_test_image)
            }
          end

          xit "has avatar for @user" do
            put :update, params: { profile: attributes }

            expect(profile.avatar.url).to(
              include("/uploads/archangel/user/avatar")
            )
          end
        end

        context "with valid params, with password" do
          let(:attributes) do
            {
              name: "Fancy Name",
              password: "new password"
            }
          end

          it "assigns the current user as @profile" do
            put :update, params: { profile: attributes }

            expect(assigns(:profile)).to eq(profile)
          end
        end

        context "with valid params, without password" do
          let(:attributes) do
            { name: "Fancy Name" }
          end

          it "assigns the current user as @profile" do
            put :update, params: { profile: attributes }

            expect(assigns(:profile)).to eq(profile)
          end
        end

        context "with invalid params" do
          let(:attributes) do
            {
              name: "Fancy Name",
              password: "no"
            }
          end

          it "assigns the current_user as @profile" do
            put :update, params: { profile: attributes }

            expect(assigns(:profile)).to eq(profile)
          end

          it "re-renders the 'edit' template" do
            put :update, params: { profile: attributes }

            expect(response).to render_template(:edit)
          end
        end
      end

      describe "DELETE #destroy" do
        it "destroys the current user" do
          expect { delete :destroy }.to change(User, :count).by(-1)
        end

        it "redirects to the root" do
          delete :destroy

          expect(response).to redirect_to(admin_root_url)
        end
      end
    end
  end
end
