# frozen_string_literal: true

module Archangel
  ##
  # Controller concerns
  #
  module Controllers
    ##
    # Backend controller concerns
    #
    module Backend
      ##
      # Resourceful concern
      #
      module ResourcefulConcern
        extend ActiveSupport::Concern

        def index
          resources = resources_content

          respond_with resources
        end

        def show
          resource = resource_content

          respond_with resource
        end

        def new
          resource = resource_new_content

          respond_with resource
        end

        def create
          resource = resource_new_content

          resource.save

          respond_with resource, location: -> { location_after_create }
        end

        def edit
          resource = resource_content

          respond_with resource
        end

        def update
          resource = resource_content

          resource.update(resource_params)

          respond_with resource, location: -> { location_after_update }
        end

        def destroy
          resource = resource_content

          resource.destroy

          respond_with resource, location: -> { location_after_destroy }
        end

        protected

        def permitted_attributes
          %w[]
        end

        def resources_content
          []
        end

        def resource_content
          {}
        end

        def resource_new_content
          action_name.to_sym == :create ? {} : nil
        end

        def resource_namespace
          controller_name.singularize.to_sym
        end

        def resource_params
          params.require(resource_namespace).permit(permitted_attributes)
        end

        def resource_new_params
          action_name.to_sym == :create ? resource_params : nil
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
          raise "I'm new! I don't know what to do!"
        end
      end
    end
  end
end
