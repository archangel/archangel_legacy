# frozen_string_literal: true

module Archangel
  ##
  # Application base policy
  #
  class ApplicationPolicy
    attr_reader :user, :record

    def initialize(user, record)
      @user = user
      @record = record
    end

    ##
    # Check if `#index` action is authorized for current user
    #
    # @return [Boolean] if action is authorized
    #
    def index?
      true
    end

    ##
    # Check if `#show` action is authorized for current user
    #
    # @return [Boolean] if action is authorized
    #
    def show?
      scope.where(id: record.id).exists?
    end

    ##
    # Check if `#create` action is authorized for current user
    #
    # @return [Boolean] if action is authorized
    #
    def create?
      true
    end

    ##
    # Check if `#new` action is authorized for current user
    #
    # @return [Boolean] if action is authorized
    #
    def new?
      create?
    end

    ##
    # Check if `#update` action is authorized for current user
    #
    # @return [Boolean] if action is authorized
    #
    def update?
      true
    end

    ##
    # Check if `#edit` action is authorized for current user
    #
    # @return [Boolean] if action is authorized
    #
    def edit?
      update?
    end

    ##
    # Check if `#destroy` action is authorized for current user
    #
    # @return [Boolean] if action is authorized
    #
    def destroy?
      true
    end

    ##
    # Nested scope
    #
    # @return [Boolean] if scaoped action is authorized
    #
    def scope
      ::Pundit.policy_scope!(user, record.class)
    end

    ##
    # Nested scope resource
    #
    class Scope
      attr_reader :user, :scope

      def initialize(user, scope)
        @user = user
        @scope = scope
      end

      ##
      # Resolvable resources
      #
      # @return [Object] iteratable resource
      #
      def resolve
        scope
      end
    end

    protected

    def admin_user?
      user.role == Archangel::ROLES.first # admin
    end
  end
end
