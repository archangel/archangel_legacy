# frozen_string_literal: true

module Archangel
  ##
  # Site policy
  #
  class SitePolicy < ApplicationPolicy
    ##
    # Check if `#update` action is authorized for current user. Based on if
    # current user has the "admin" role
    #
    # @return [Boolean] true when User is an "admin" role
    #
    def update?
      admin_user?
    end
  end
end
