# frozen_string_literal: true

module Archangel
  ##
  # Controller action concern
  #
  module ActionableConcern
    extend ActiveSupport::Concern

    included do
      helper_method :action,
                    :action?,
                    :collection_action?,
                    :edit_action?,
                    :index_action?,
                    :member_action?,
                    :new_action?,
                    :restful_action?,
                    :save_action?,
                    :show_action?
    end

    # Controller action name as a symbol
    #
    # @return [Symbol] the action name
    def action
      action_name.to_sym
    end

    # Test if action is a collection action
    #
    # Actions include [:index]
    #
    # Collection actions can be modified by overwriting `#collection_actions`
    #
    # @return [Boolean] if action is a collection action
    def collection_action?
      collection_actions.include?(action)
    end

    # Test if action is an edit action
    #
    # Actions include [:edit, :update]
    #
    # Edit actions can be modified by overwriting `#edit_actions`
    #
    # @return [Boolean] if action is an edit action
    def edit_action?
      edit_actions.include?(action)
    end

    # Test if action is the `index` action
    #
    # @return [Boolean] if action is the index action
    def index_action?
      action?(:index)
    end

    # Test if action is a member action
    #
    # Actions include [:show, :edit, :update, :destroy]
    #
    # Member actions can be modified by overwriting `#member_actions`
    #
    # @return [Boolean] if action is an edit action
    def member_action?
      member_actions.include?(action)
    end

    # Test if action is a new action
    #
    # Actions include [:create, :new]
    #
    # New actions can be modified by overwriting `#new_actions`
    #
    # @return [Boolean] if action is an edit action
    def new_action?
      new_actions.include?(action)
    end

    # Test if action is a RESTful action
    #
    # Actions include [:index, :show, :new, :create, :edit, :update, :destroy]
    #
    # RESTful actions can be modified by overwriting `#restful_actions`
    #
    # @return [Boolean] if action is an edit action
    def restful_action?
      restful_actions.include?(action)
    end

    # Test if action is a save action
    #
    # Actions include [:create, :update, :destroy]
    #
    # Save actions can be modified by overwriting `#save_actions`
    #
    # @return [Boolean] if action is an edit action
    def save_action?
      save_actions.include?(action)
    end

    # Test if action is a show action
    #
    # Actions include [:show]
    #
    # Show actions can be modified by overwriting `#show_actions`
    #
    # @return [Boolean] if action is a show action
    def show_action?
      show_actions.include?(action)
    end

    protected

    def action?(action_method)
      action == action_method.to_sym
    end

    def collection_actions
      %i[index]
    end

    def destroy_actions
      %i[destroy]
    end

    def edit_actions
      %i[edit update]
    end

    def member_actions
      edit_actions + show_actions + destroy_actions
    end

    def new_actions
      %i[create new]
    end

    def restful_actions
      %i[create destroy edit index new show update]
    end

    def save_actions
      %i[create destroy update]
    end

    def show_actions
      %i[show]
    end
  end
end
