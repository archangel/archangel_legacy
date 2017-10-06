# frozen_string_literal: true

module Archangel
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

    def action
      action_name.to_sym
    end

    def action?(action_method)
      action == action_method.to_sym
    end

    def collection_action?
      collection_actions.include?(action)
    end

    def edit_action?
      %i[edit update].include?(action)
    end

    def index_action?
      action?(:index)
    end

    def member_action?
      member_actions.include?(action)
    end

    def new_action?
      %i[create new].include?(action)
    end

    def restful_action?
      restful_actions.include?(action)
    end

    def save_action?
      save_actions.include?(action)
    end

    def show_action?
      action?(:show)
    end

    protected

    def collection_actions
      %i[index]
    end

    def member_actions
      %i[destroy edit show update]
    end

    def restful_actions
      %i[create destroy edit index new show update]
    end

    def save_actions
      %i[create destroy update]
    end
  end
end
