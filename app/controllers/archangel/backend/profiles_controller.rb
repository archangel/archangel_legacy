# frozen_string_literal: true

module Archangel
  module Backend
    class ProfilesController < BackendController
      include Archangel::SkipAuthorizableConcern

      before_action :set_resource

      def show
        respond_with @profile
      end

      def edit
        respond_with @profile
      end

      def update
        empty_password_params! if resource_params[:password].blank?

        successfully_updated = if needs_password?(@profile, resource_params)
                                 @profile.update resource_params
                               else
                                 @profile.update_without_password(
                                   resource_params
                                 )
                               end

        reauth_current_user(successfully_updated)

        respond_with @profile, location: -> { location_after_update }
      end

      def destroy
        @profile.destroy

        respond_with @profile, location: -> { location_after_destroy }
      end

      protected

      def permitted_attributes
        %w[avatar email name password remove_avatar username]
      end

      def set_resource
        @profile = current_user
      end

      def resource_params
        params.require(resource_namespace).permit(permitted_attributes)
      end

      def resource_namespace
        :profile
      end

      def location_after_update
        location_after_save
      end

      def location_after_destroy
        backend_root_path
      end

      def location_after_save
        backend_profile_path
      end

      def empty_password_params!
        resource_params.delete(:password)
        resource_params.delete(:password_confirmation)
      end

      def needs_password?(_profile, params)
        params[:password].present?
      end

      def reauth_current_user(successful)
        bypass_sign_in(@profile) if successful
      end
    end
  end
end
