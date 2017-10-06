# frozen_string_literal: true

require "rails_helper"

module Archangel
  module Backend
    RSpec.describe WidgetsController, type: :controller do
      before { stub_authorization! }

      describe "GET #index" do
        it "assigns all resources as @widgets" do
          widget_a = create(:widget, name: "First")
          widget_b = create(:widget, name: "Second")
          widget_c = create(:widget, name: "Third")

          get :index

          expect(assigns(:widgets)).to eq(
            [widget_a, widget_b, widget_c]
          )
        end
      end

      describe "GET #show" do
        it "assigns the requested resource as @widget" do
          widget = create(:widget)

          get :show, params: { id: widget }

          expect(assigns(:widget)).to eq(widget)
        end
      end

      describe "GET #new" do
        it "assigns a new resource as Widget" do
          get :new

          expect(assigns(:widget)).to be_a_new(Widget)
        end
      end

      describe "POST #create" do
        context "with valid params" do
          let(:params) do
            {
              name: "New Widget Name",
              slug: "new-widget",
              content: "<p>Widget content</p>"
            }
          end

          it "creates a new resource" do
            expect do
              post :create, params: { widget: params }
            end.to change(Widget, :count).by(1)
          end

          it "assigns a newly created resource as @widget" do
            post :create, params: { widget: params }

            expect(assigns(:widget)).to be_a(Widget)
            expect(assigns(:widget)).to be_persisted
          end

          it "redirects after creating resource" do
            post :create, params: { widget: params }

            expect(response).to redirect_to(backend_widgets_path)
          end
        end

        context "with invalid params" do
          let(:params) do
            {
              name: nil,
              slug: nil,
              content: nil
            }
          end

          it "assigns a newly created but unsaved resource as @widget" do
            post :create, params: { widget: params }

            expect(assigns(:widget)).to be_a_new(Widget)
          end

          it "re-renders the `new` view" do
            post :create, params: { widget: params }

            expect(response).to render_template(:new)
          end
        end
      end

      describe "GET #edit" do
        it "assigns the requested resource as @widget" do
          widget = create(:widget)

          get :edit, params: { id: widget }

          expect(assigns(:widget)).to eq(widget)
        end
      end

      describe "PUT #update" do
        context "with valid params" do
          let(:params) do
            {
              name: "Updated Widget Name",
              slug: "updated-widget",
              content: "<p>Updated widget content</p>"
            }
          end

          it "updates the requested resource" do
            widget = create(:widget)

            put :update, params: { id: widget, widget: params }

            widget.reload

            expect(assigns(:widget)).to eq(widget)
          end

          it "assigns the requested resource as @widget" do
            widget = create(:widget)

            put :update, params: { id: widget, widget: params }

            expect(assigns(:widget)).to eq(widget)
          end

          it "redirects after updating resource" do
            widget = create(:widget)

            put :update, params: { id: widget, widget: params }

            expect(response).to redirect_to(backend_widgets_path)
          end
        end

        context "with invalid params" do
          let(:params) do
            {
              name: nil,
              slug: nil,
              content: nil
            }
          end

          it "assigns the resource as @widget" do
            widget = create(:widget)

            put :update, params: { id: widget, widget: params }

            expect(assigns(:widget)).to eq(widget)
          end

          it "re-renders the `edit` view" do
            widget = create(:widget)

            put :update, params: { id: widget, widget: params }

            expect(response).to render_template(:edit)
          end
        end
      end

      describe "DELETE #destroy" do
        it "destroys the requested resource" do
          widget = create(:widget)

          expect do
            delete :destroy, params: { id: widget }
          end.to change(Widget, :count).by(-1)
        end

        it "redirects to the listing" do
          widget = create(:widget)

          delete :destroy, params: { id: widget }

          expect(response).to redirect_to(backend_widgets_path)
        end
      end
    end
  end
end
