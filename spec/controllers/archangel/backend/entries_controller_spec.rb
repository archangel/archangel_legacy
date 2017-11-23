# frozen_string_literal: true

require "rails_helper"

module Archangel
  module Backend
    RSpec.describe EntriesController, type: :controller do
      before { stub_authorization! create(:user) }
    end
  end
end
