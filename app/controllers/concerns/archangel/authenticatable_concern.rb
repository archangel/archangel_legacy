# frozen_string_literal: true

module Archangel
  ##
  # Controller authenticate concern
  #
  module AuthenticatableConcern
    extend ActiveSupport::Concern

    included do
      before_action :authenticate_user!
    end
  end
end
