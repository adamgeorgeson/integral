module Integral
  # Handles Post authorization
  class PostPolicy
    attr_reader :user, :instance

    def initialize(user, instance)
      @user = user
      @instance = instance
    end

    def manager?
      user.has_role?(:post_manager)
    end

    alias_method :destroy?, :manager?
    alias_method :index?, :manager?
    alias_method :show?, :manager?
    alias_method :new?, :manager?
    alias_method :create?, :manager?
    alias_method :edit?, :manager?
    alias_method :update?, :manager?
  end
end