# frozen_string_literal: true

require "rails_helper"

module Archangel
  module Backend
    RSpec.describe DashboardsController, type: :controller do
      describe "GET #show" do
        it "loads correct view" do
          get :show

          expect(response).to render_template(:show)
        end
      end
    end
  end
end
