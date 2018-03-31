# frozen_string_literal: true

module Archangel
  ##
  # Asset policy
  #
  class AssetPolicy < ApplicationPolicy
    ##
    # Check if `#wysiwyg` action is authorized for current user.
    #
    # @return [Boolean] if action is authorized
    #
    def wysiwyg?
      true
    end
  end
end
