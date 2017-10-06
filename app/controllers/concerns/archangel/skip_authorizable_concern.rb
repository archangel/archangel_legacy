# frozen_string_literal: true

module Archangel
  module SkipAuthorizableConcern
    extend ActiveSupport::Concern

    included do
      after_action :skip_authorization
    end
  end
end
