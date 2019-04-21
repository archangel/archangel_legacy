# frozen_string_literal: true

module Archangel
  ##
  # @see Archangel::AuthController
  #
  module Auth
    ##
    # Authentication registrations controller
    #
    class RegistrationsController < Devise::RegistrationsController
      before_action :allow_registration,
                    only: %i[cancel create destroy edit new update]

      protected

      def after_sign_up_path_for(resource)
        stored_location_for(resource) || root_path
      end

      def after_inactive_sign_up_path_for(resource)
        after_sign_up_path_for(resource)
      end

      def sign_up_params
        super.merge(site_id: current_site.id)
      end

      def allow_registration
        return render_404_error unless current_site.allow_registration?
      end
    end
  end
end
