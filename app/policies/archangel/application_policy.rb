# frozen_string_literal: true

module Archangel
  ##
  # Application base policy
  #
  class ApplicationPolicy
    ##
    # Record to check
    #
    attr_reader :record

    ##
    # User to check policy for
    #
    attr_reader :user

    ##
    # Policy initializer
    #
    # @param user [Object] the user
    # @param record [Object] the record
    #
    def initialize(user, record)
      @user = user
      @record = record
    end

    ##
    # Check if `#index` action is authorized for current user
    #
    # @return [Boolean] true for all roles
    #
    def index?
      true
    end

    ##
    # Check if `#show` action is authorized for current user
    #
    # @return [Boolean] true if record exists
    #
    def show?
      scope.where(id: record.id).exists?
    end

    ##
    # Check if `#create` action is authorized for current user
    #
    # @return [Boolean] true for all roles
    #
    def create?
      true
    end

    ##
    # Check if `#new` action is authorized for current user
    #
    # @return [Boolean] true if also able to create record
    #
    def new?
      create?
    end

    ##
    # Check if `#update` action is authorized for current user
    #
    # @return [Boolean] true for all roles
    #
    def update?
      true
    end

    ##
    # Check if `#edit` action is authorized for current user
    #
    # @return [Boolean] true if also able to update record
    #
    def edit?
      update?
    end

    ##
    # Check if `#destroy` action is authorized for current user
    #
    # @return [Boolean] true for all roles
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
      ##
      # Scope to check
      #
      attr_reader :scope

      ##
      # User to check policy for
      #
      attr_reader :user

      ##
      # Policy scope initializer
      #
      # @param user [Object] the user
      # @param scope [Object] the scope
      #
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
