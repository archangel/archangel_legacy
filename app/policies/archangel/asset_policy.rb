# frozen_string_literal: true

module Archangel
  ##
  # Asset policy
  #
  class AssetPolicy < ApplicationPolicy
    ##
    # Check if `#wysiwyg` action is authorized for current user.
    #
    # @return [Boolean] true for all roles
    #
    def wysiwyg?
      true
    end
  end
end
