# frozen_string_literal: true

require "rails_helper"

module Archangel
  RSpec.describe BackendController, type: :controller do
    before { stub_authorization! }

    controller do
      include Archangel::Controllers::Backend::ResourcefulConcern
      include Archangel::SkipAuthorizableConcern

      def location_after_save
        backend_root_path
      end
    end

    describe "GET #index" do
      it "assigns all resources as empty array" do
        get :index, format: :json

        expect(JSON.parse(response.body)).to eq([])
      end
    end

    describe "GET #show" do
      it "assigns the requested resource as blank" do
        get :show, params: { id: 1 }

        expect(response.body).to eq("")
      end
    end

    describe "GET #new" do
      it "assigns a new resource as nil" do
        get :new

        expect(assigns(:backend)).to be_nil
      end
    end

    describe "POST #create" do
      context "with params" do
        let(:params) do
          {
            foo: "bar"
          }
        end

        it "redirects after creating resource" do
          post :create, params: { backend: params }

          expect(response).to redirect_to(backend_root_path)
        end
      end
    end

    describe "GET #edit" do
      it "assigns the requested resource as blank" do
        get :edit, params: { id: 1 }

        expect(response.body).to eq("")
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:params) do
          {
            foo: "bar"
          }
        end

        it "redirects after updating resource" do
          put :update, params: { id: 1, backend: params }

          expect(response).to redirect_to(backend_root_path)
        end
      end
    end

    describe "DELETE #destroy" do
      it "redirects to the listing" do
        delete :destroy, params: { id: 1 }

        expect(response).to redirect_to(backend_root_path)
      end
    end
  end
end
