# frozen_string_literal: true

module Archangel
  ##
  # Controller action concern
  #
  module ActionableConcern
    extend ActiveSupport::Concern

    included do
      helper_method :action,
                    :collection_action?,
                    :create_action?,
                    :destroy_action?,
                    :edit_action?,
                    :index_action?,
                    :member_action?,
                    :new_action?,
                    :show_action?,
                    :update_action?
    end

    %w[create destroy edit index new show update].each do |rest_action|
      define_method("#{rest_action}_action?".to_sym) do
        action?(rest_action)
      end
    end

    # Controller action name as a symbol
    #
    # @return [Symbol] the action name
    #
    def action
      action_name.to_sym
    end

    # Test if action is a collection action
    #
    # Actions include [:index]
    #
    # @return [Boolean] if action is a collection action
    #
    def collection_action?
      collection_actions.include?(action)
    end

    # Test if action is a member action
    #
    # Actions include [:show, :edit, :update, :destroy]
    #
    # @return [Boolean] if action is a member action
    #
    def member_action?
      member_actions.include?(action)
    end

    protected

    def action?(action_method)
      action == action_method.to_sym
    end

    def collection_actions
      %i[index]
    end

    def member_actions
      %i[destroy edit show update]
    end
  end
end
