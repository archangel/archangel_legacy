# frozen_string_literal: true

require "rails_helper"

module Archangel
  module Backend
    RSpec.describe TemplatesController, type: :controller do
      before { stub_authorization! }

      describe "GET #index" do
        it "assigns all resources as @templates" do
          site = create(:site)

          template_a = create(:template, site: site, name: "First")
          template_b = create(:template, site: site, name: "Second")
          template_c = create(:template, site: site, name: "Third")

          get :index

          expect(assigns(:templates)).to eq(
            [template_a, template_b, template_c]
          )
        end
      end

      describe "GET #show" do
        it "assigns the requested resource as @template" do
          template = create(:template)

          get :show, params: { id: template }

          expect(assigns(:template)).to eq(template)
        end
      end

      describe "GET #new" do
        it "assigns a new resource as Template" do
          get :new

          expect(assigns(:template)).to be_a_new(Template)
        end
      end

      describe "POST #create" do
        context "with valid params" do
          let(:params) do
            {
              name: "New Template",
              content: "<p>Template content</p>",
              partial: false
            }
          end

          it "creates a new resource" do
            expect do
              post :create, params: { template: params }
            end.to change(Template, :count).by(1)
          end

          it "assigns a newly created resource as @template" do
            post :create, params: { template: params }

            expect(assigns(:template)).to be_a(Template)
            expect(assigns(:template)).to be_persisted
          end

          it "redirects after creating resource" do
            post :create, params: { template: params }

            expect(response).to redirect_to(backend_templates_path)
          end
        end

        context "with invalid params" do
          let(:params) do
            {
              name: nil,
              content: nil,
              partial: nil
            }
          end

          it "assigns a newly created but unsaved resource as @template" do
            post :create, params: { template: params }

            expect(assigns(:template)).to be_a_new(Template)
          end

          it "re-renders the `new` view" do
            post :create, params: { template: params }

            expect(response).to render_template(:new)
          end
        end
      end

      describe "GET #edit" do
        it "assigns the requested resource as @template" do
          template = create(:template)

          get :edit, params: { id: template }

          expect(assigns(:template)).to eq(template)
        end
      end

      describe "PUT #update" do
        context "with valid params" do
          let(:params) do
            {
              name: "Updated template name",
              content: "<p>Updated template content.</p>",
              partial: false
            }
          end

          it "updates the requested resource" do
            template = create(:template)

            put :update, params: { id: template, template: params }

            template.reload

            expect(assigns(:template)).to eq(template)
          end

          it "assigns the requested resource as @template" do
            template = create(:template)

            put :update, params: { id: template, template: params }

            expect(assigns(:template)).to eq(template)
          end

          it "redirects after updating resource" do
            template = create(:template)

            put :update, params: { id: template, template: params }

            expect(response).to redirect_to(backend_templates_path)
          end
        end

        context "with invalid params" do
          let(:params) do
            {
              name: nil,
              content: nil,
              partial: nil
            }
          end

          it "assigns the resource as @template" do
            template = create(:template)

            put :update, params: { id: template, template: params }

            expect(assigns(:template)).to eq(template)
          end

          it "re-renders the `edit` view" do
            template = create(:template)

            put :update, params: { id: template, template: params }

            expect(response).to render_template(:edit)
          end
        end
      end

      describe "DELETE #destroy" do
        it "destroys the requested resource" do
          template = create(:template)

          expect do
            delete :destroy, params: { id: template }
          end.to change(Template, :count).by(-1)
        end

        it "redirects to the listing" do
          template = create(:template)

          delete :destroy, params: { id: template }

          expect(response).to redirect_to(backend_templates_path)
        end
      end
    end
  end
end
