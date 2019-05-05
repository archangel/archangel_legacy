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
      include Archangel::Controllers::ResourcefulConcern

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
      # Parameters
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
        user = resource_new_content

        respond_with user, location: -> { location_after_create }
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
      # Parameters
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
        user = resource_content

        user.update_without_password(resource_params)

        respond_with user, location: -> { location_after_update }
      end

      protected

      def permitted_attributes
        %w[email locale name remove_avatar role username]
      end

      def resources_content
        @users = current_site.users
                             .where.not(id: current_user.id)
                             .order(name: :asc)
                             .page(page_num).per(per_page)

        authorize @users
      end

      def resource_content
        resource_id = params.fetch(:id)

        @user = current_site.users
                            .where.not(id: current_user.id)
                            .find_by!(username: resource_id)

        authorize @user
      end

      def resource_new_content
        @user = current_site.users.new

        if action_name.to_sym == :create
          @user = current_site.users.invite!(resource_new_params, current_user)
        end

        authorize @user
      end
    end
  end
end
