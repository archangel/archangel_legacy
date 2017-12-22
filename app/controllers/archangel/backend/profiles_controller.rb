# frozen_string_literal: true

module Archangel
  ##
  # @see Archangel::BackendController
  #
  module Backend
    ##
    # Backend profiles controller
    #
    class ProfilesController < BackendController
      include Archangel::SkipAuthorizableConcern

      before_action :set_resource

      ##
      # Backend profile
      #
      # Formats
      #   HTML, JSON
      #
      # Request
      #   GET /backend/profile
      #   GET /backend/profile.json
      #
      # Response
      #   {
      #     "id": 123,
      #     "site_id": 123,
      #     "name": "First Last",
      #     "username": "my_username"
      #     "role": "admin",
      #     "avatar": {
      #       "url": "/uploads/file.png",
      #       "large": {
      #         "url": "/uploads/large_file.png"
      #       },
      #       "medium": {
      #         "url": "/uploads/medium_file.png"
      #       },
      #       "small": {
      #         "url": "/uploads/small_file.png"
      #       },
      #       "tiny": {
      #         "url": "/uploads/tiny_file.png"
      #       }
      #     },
      #     "email": "me@example.com",
      #     "invitation_token": null,
      #     "invitation_created_at": null,
      #     "invitation_sent_at": null,
      #     "invitation_accepted_at": null,
      #     "invitation_limit": null,
      #     "invited_by_type": null,
      #     "invited_by_id": null,
      #     "invitations_count": 0,
      #     "deleted_at": null,
      #     "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      #   }
      #
      def show
        respond_with @profile
      end

      ##
      # Edit backend profile
      #
      # Formats
      #   HTML, JSON
      #
      # Request
      #   GET /backend/profile
      #   GET /backend/profile.json
      #
      # Response
      #   {
      #     "id": 123,
      #     "site_id": 123,
      #     "name": "First Last",
      #     "username": "my_username"
      #     "role": "admin",
      #     "avatar": {
      #       "url": "/uploads/file.png",
      #       "large": {
      #         "url": "/uploads/large_file.png"
      #       },
      #       "medium": {
      #         "url": "/uploads/medium_file.png"
      #       },
      #       "small": {
      #         "url": "/uploads/small_file.png"
      #       },
      #       "tiny": {
      #         "url": "/uploads/tiny_file.png"
      #       }
      #     },
      #     "email": "me@example.com",
      #     "invitation_token": null,
      #     "invitation_created_at": null,
      #     "invitation_sent_at": null,
      #     "invitation_accepted_at": null,
      #     "invitation_limit": null,
      #     "invited_by_type": null,
      #     "invited_by_id": null,
      #     "invitations_count": 0,
      #     "deleted_at": null,
      #     "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      #   }
      #
      def edit
        respond_with @profile
      end

      ##
      # Update backend profile
      #
      # Formats
      #   HTML, JSON
      #
      # Request
      #   PATCH /backend/profile
      #   PUT   /backend/profile.json
      #
      # Response
      #   {
      #     "profile": {
      #       "name": "First Last",
      #       "username": "my_username"
      #       "avatar": "local/path/to/new_file.gif"
      #       "email": "me@example.com"
      #     }
      #   }
      #
      def update
        empty_password_params! if resource_params[:password].blank?

        successfully_updated =
          if needs_password?(@profile, resource_params)
            @profile.update(resource_params)
          else
            @profile.update_without_password(resource_params)
          end

        reauth_current_user(successfully_updated)

        respond_with @profile, location: -> { location_after_update }
      end

      ##
      # Destroy backend profile
      #
      # Formats
      #   HTML, JSON
      #
      # Request
      #   DELETE /backend/profile
      #   DELETE /backend/profile.json
      #
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
        controller_name.singularize.to_sym
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
