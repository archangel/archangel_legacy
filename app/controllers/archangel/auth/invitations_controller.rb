# frozen_string_literal: true

module Archangel
  ##
  # @see Archangel::AuthController
  #
  module Auth
    ##
    # Authentication invitations controller
    #
    class InvitationsController < Devise::InvitationsController
      before_action :configure_permitted_parameters, if: :devise_controller?

      protected

      def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:accept_invitation,
                                          keys: %i[name username])
      end
    end
  end
end
