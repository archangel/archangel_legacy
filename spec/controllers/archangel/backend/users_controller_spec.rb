# frozen_string_literal: true

require "rails_helper"

module Archangel
  module Backend
    RSpec.describe UsersController, type: :controller do
      before { stub_authorization! user }

      let(:site) { create(:site) }
      let(:user) { create(:user, site: site) }

      describe "GET #show" do
        it "assigns the requested user as @user" do
          user = create(:user, site: site)

          get :show, params: { id: user }

          expect(assigns(:user)).to eq(user)
        end

        it "uses default avatar for user" do
          user = create(:user, site: site)

          get :show, params: { id: user }

          expect(user.avatar.url).to(
            include("/assets/archangel/fallback/avatar")
          )
        end

        it "uses uploader avatar for user" do
          user = create(:user, :avatar, site: site)

          get :show, params: { id: user }

          expect(user.avatar.url).to include("/uploads/archangel/user/avatar")
        end
      end

      describe "POST #create" do
        context "with valid params" do
          let(:attributes) do
            {
              name: "Fake User",
              username: "fake_user",
              email: "fake_user@example.com"
            }
          end

          it "redirects to the created user" do
            post :create, params: { user: attributes }

            expect(response).to redirect_to(backend_users_path)
          end
        end

        context "with invalid params" do
          let(:existing_user) { create(:user, site: site) }
          let(:attributes) do
            { email: existing_user.email }
          end

          it "re-renders the 'new' template" do
            post :create, params: { user: attributes }

            expect(response).to render_template(:new)
          end
        end
      end

      describe "PUT #update" do
        context "with valid params" do
          let(:attributes) do
            { email: "new_email@example.com" }
          end

          it "redirects to the user" do
            user = create(:user, site: site)

            put :update, params: { id: user, user: attributes }

            expect(response).to redirect_to(backend_users_path)
          end
        end

        context "with invalid params" do
          let(:existing_user) { create(:user, site: site) }
          let(:attributes) do
            { email: existing_user.email }
          end

          it "re-renders the 'edit' template" do
            user = create(:user, site: site)

            put :update, params: { id: user.to_param, user: attributes }

            expect(response).to render_template(:edit)
          end
        end
      end

      describe "DELETE #destroy" do
        it "redirects to the users list" do
          user = create(:user, site: site)

          delete :destroy, params: { id: user.to_param }

          expect(response).to redirect_to(backend_users_path)
        end
      end
    end
  end
end
