# frozen_string_literal: true

require "rails_helper"

module Archangel
  module Backend
    RSpec.describe ProfilesController, type: :controller do
      before { stub_authorization! profile }

      let(:profile) { create(:user) }

      describe "DELETE #destroy" do
        it "redirects to the root" do
          delete :destroy

          expect(response).to redirect_to(backend_root_path)
        end
      end
    end
  end
end
