# frozen_string_literal: true

module Archangel
  ##
  # @see Archangel::BackendController
  #
  module Backend
    ##
    # Backend users controller
    #
    class UsersController < BackendController
      before_action :set_resources, only: %i[index]
      before_action :set_resource, only: %i[destroy edit show update]
      before_action :set_new_resource, only: %i[create new]

      ##
      # Backend users
      #
      # Formats
      #   HTML, JSON
      #
      # Request
      #   GET /backend/users
      #   GET /backend/users.json
      #
      # Response
      #   [
      #     {
      #       "id": 123,
      #       "site_id": 123,
      #       "name": "First Last",
      #       "username": "user_name",
      #       "role": "editor",
      #       "avatar": {
      #         "url": "/uploads/file.png",
      #         "large": {
      #           "url": "/uploads/large_file.png"
      #         },
      #         "medium": {
      #           "url": "/uploads/medium_file.png"
      #         },
      #         "small": {
      #           "url": "/uploads/small_file.png"
      #         },
      #         "tiny": {
      #           "url": "/uploads/tiny_file.png"
      #         }
      #       },
      #       "email": "me@example.com",
      #       "invitation_token": "abc123xyz",
      #       "invitation_created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #       "invitation_sent_at": null,
      #       "invitation_accepted_at": null,
      #       "invitation_limit": null,
      #       "invited_by_type": "Archangel::User",
      #       "invited_by_id": 2,
      #       "invitations_count": 0,
      #       "deleted_at": null,
      #       "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #       "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      #     },
      #     ...
      #   ]
      #
      def index
        respond_with @users
      end

      ##
      # Backend user
      #
      # Formats
      #   HTML, JSON
      #
      # Params
      #   [String] username - the user username
      #
      # Request
      #   GET /backend/users/:username
      #   GET /backend/users/:username.json
      #
      # Response
      #   {
      #     "id": 123,
      #     "site_id": 123,
      #     "name": "First Last",
      #     "username": "user_name",
      #     "role": "editor",
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
      #     "invitation_token": "abc123xyz",
      #     "invitation_created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "invitation_sent_at": null,
      #     "invitation_accepted_at": null,
      #     "invitation_limit": null,
      #     "invited_by_type": "Archangel::User",
      #     "invited_by_id": 2,
      #     "invitations_count": 0,
      #     "deleted_at": null,
      #     "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      #   }
      #
      def show
        respond_with @user
      end

      ##
      # New backend user
      #
      # Formats
      #   HTML, JSON
      #
      # Request
      #   GET /backend/users/new
      #   GET /backend/users/new.json
      #
      # Response
      #   {
      #     "id": null,
      #     "site_id": 123,
      #     "name": null,
      #     "username": null,
      #     "role": "editor",
      #     "avatar": {
      #       "url": null,
      #       "large": {
      #         "url": null
      #       },
      #       "medium": {
      #         "url": null
      #       },
      #       "small": {
      #         "url": null
      #       },
      #       "tiny": {
      #         "url": null
      #       }
      #     },
      #     "email": null,
      #     "invitation_token": null,
      #     "invitation_created_at": null,
      #     "invitation_sent_at": null,
      #     "invitation_accepted_at": null,
      #     "invitation_limit": null,
      #     "invited_by_type": null,
      #     "invited_by_id": null,
      #     "invitations_count": 0,
      #     "deleted_at": null,
      #     "created_at": null,
      #     "updated_at": null,
      #   }
      #
      def new
        respond_with @user
      end

      ##
      # Invite backend user
      #
      # Formats
      #   HTML, JSON
      #
      # Request
      #   POST /backend/users
      #   POST /backend/users.json
      #
      # Paramaters
      #   {
      #     "user": {
      #       "name": "First Last",
      #       "username": "user_name",
      #       "role": "editor",
      #       "avatar": "/uploads/file.png",
      #       "email": "me@example.com"
      #     }
      #   }
      #
      def create
        @user.invite! @user

        respond_with @user, location: -> { location_after_create }
      end

      ##
      # Edit backend user
      #
      # Formats
      #   HTML, JSON
      #
      # Params
      #   [String] username - the user username
      #
      # Request
      #   GET /backend/users/:username/edit
      #   GET /backend/users/:username/edit.json
      #
      # Response
      #   {
      #     "id": 123,
      #     "site_id": 123,
      #     "name": "First Last",
      #     "username": "user_name",
      #     "role": "editor",
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
      #     "invitation_token": "abc123xyz",
      #     "invitation_created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "invitation_sent_at": null,
      #     "invitation_accepted_at": null,
      #     "invitation_limit": null,
      #     "invited_by_type": "Archangel::User",
      #     "invited_by_id": 2,
      #     "invitations_count": 0,
      #     "deleted_at": null,
      #     "created_at": "YYYY-MM-DDTHH:MM:SS.MSZ",
      #     "updated_at": "YYYY-MM-DDTHH:MM:SS.MSZ"
      #   }
      #
      def edit
        respond_with @user
      end

      ##
      # Update backend user
      #
      # Formats
      #   HTML, JSON
      #
      # Params
      #   [String] slug - the user username
      #
      # Request
      #   PATCH /backend/users/:slug
      #   PATCH /backend/users/:slug.json
      #   PUT   /backend/users/:slug
      #   PUT   /backend/users/:slug.json
      #
      # Paramaters
      #   {
      #     "user": {
      #       "name": "First Last",
      #       "username": "user_name",
      #       "role": "editor",
      #       "avatar": "/uploads/file.png",
      #       "email": "me@example.com"
      #     }
      #   }
      #
      def update
        @user.update_without_password(resource_params)

        respond_with @user, location: -> { location_after_update }
      end

      ##
      # Destroy backend user
      #
      # Formats
      #   HTML, JSON
      #
      # Params
      #   [String] username - the user username
      #
      # Request
      #   DELETE /backend/users/:username
      #   DELETE /backend/users/:username.json
      #
      def destroy
        @user.destroy

        respond_with @user, location: -> { location_after_destroy }
      end

      protected

      def permitted_attributes
        %w[email locale name remove_avatar role username]
      end

      def set_resources
        @users = current_site.users
                             .where.not(id: current_user.id)
                             .page(page_num).per(per_page)

        authorize @users
      end

      def set_resource
        resource_id = params.fetch(:id)

        @user = current_site.users
                            .where.not(id: current_user.id)
                            .order(name: :asc)
                            .find_by!(username: resource_id)

        authorize @user
      end

      def set_new_resource
        users = current_site.users
        @user = users.new

        if action_name.to_sym == :create
          @user = users.invite!(resource_params) do |user|
            user.skip_invitation = true
          end
        end

        authorize @user
      end

      def resource_params
        params.require(resource_namespace).permit(permitted_attributes)
      end

      def resource_namespace
        controller_name.singularize.to_sym
      end

      def location_after_create
        location_after_save
      end

      def location_after_update
        location_after_save
      end

      def location_after_destroy
        location_after_save
      end

      def location_after_save
        backend_users_path
      end
    end
  end
end
