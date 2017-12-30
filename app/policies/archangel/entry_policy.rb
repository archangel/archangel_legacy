# frozen_string_literal: true

module Archangel
  ##
  # Entry policy
  #
  class EntryPolicy < ApplicationPolicy
    ##
    # Check if `#sort` action is authorized for current user
    #
    # @return [Boolean] if action is authorized
    #
    def sort?
      true
    end
  end
end
