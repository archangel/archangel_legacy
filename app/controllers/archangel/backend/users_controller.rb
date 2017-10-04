# frozen_string_literal: true

module Archangel
  module Backend
    class UsersController < BackendController
      before_action :set_resources, only: %i[index]
      before_action :set_resource, only: %i[destroy edit show update]
      before_action :set_new_resource, only: %i[create new]

      def index
        respond_with @users
      end

      def show
        respond_with @user
      end

      def new
        respond_with @user
      end

      def create
        @user.invite! @user

        respond_with @user, location: -> { location_after_create }
      end

      def edit
        respond_with @user
      end

      def update
        @user.update_without_password(resource_params)

        respond_with @user, location: -> { location_after_update }
      end

      def destroy
        @user.destroy

        respond_with @user, location: -> { location_after_destroy }
      end

      protected

      def permitted_attributes
        %i[email locale name remove_avatar role username]
      end

      def set_resources
        @users = Archangel::User.where.not(id: current_user.id)
                                .page(page_num)
                                .per(per_page)
      end

      def set_resource
        @user = Archangel::User.where.not(id: current_user.id)
                               .find_by!(username: params[:id])
      end

      def set_new_resource
        @user = Archangel::User.new

        if action_name.to_sym == :create
          @user = Archangel::User.invite!(resource_params) do |user|
            user.skip_invitation = true
          end
        end
      end

      def resource_params
        params.require(resource_namespace).permit(permitted_attributes)
      end

      def resource_namespace
        :user
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
