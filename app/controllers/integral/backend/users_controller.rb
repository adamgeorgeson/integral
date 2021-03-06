module Integral
  module Backend
    # Users controller
    class UsersController < BaseController
      before_filter :set_user, only: [:edit, :update, :destroy, :show]

      before_filter :authorize_with_instance, only: [ :show, :edit, :update ]
      before_filter :authorize_with_klass, only: [ :index, :new, :create, :destroy ]

      before_filter :set_breadcrumbs

      # GET /
      # Lists all users
      def index
        @users_grid = initialize_grid(User)
      end

      # GET /new
      # User creation form
      def new
        add_breadcrumb I18n.t('integral.breadcrumbs.new'), :new_backend_user_path
        @user = User.new
      end

      # GET /:id
      # Show specific user
      #
      def show
        add_breadcrumb @user.name, :backend_user_path
      end

      # GET /account
      # Show specific users account page
      #
      def account
        @user = current_user
        add_breadcrumb @user.name, :backend_account_path

        render :show
      end

      # POST /
      # User creation
      def create
        @user = User.invite!(user_params, current_user)

        if @user.errors.present?
          respond_failure I18n.t('integral.backend.users.notification.creation_failure'), 'new'
        else
          respond_successfully I18n.t('integral.backend.users.notification.creation_success'), backend_user_path(@user)
        end
      end

      # GET /:id/edit
      # User edit form
      def edit
        add_breadcrumb @user.name, :backend_user_path
        add_breadcrumb I18n.t('integral.breadcrumbs.edit'), :edit_backend_user_path
      end

      # PUT /:id
      # Updating a user
      def update
        authorized_user_params = user_params
        authorized_user_params.delete(:role_ids) unless policy(@user).manager?

        if @user.update(authorized_user_params)
          respond_successfully I18n.t('integral.backend.users.notification.edit_success'), backend_user_path(@user)
        else
          respond_failure I18n.t('integral.backend.users.notification.edit_failure'), 'edit'
        end
      end

      # DELETE /:id
      def destroy
        @user.destroy

        respond_successfully I18n.t('integral.backend.users.notification.delete_success'), backend_users_path
      end

      private

      def respond_successfully(flash_message, redirect_path)
        flash[:notice] = flash_message
        redirect_to redirect_path
      end

      def respond_failure(flash_message, template)
        flash.now[:error] = flash_message
        render template
      end

      def set_user
        @user = User.find(params[:id])
      end

      def user_params
        return params.require(:user).permit(:name, :email, :avatar, :locale, role_ids: [] ) unless params[:user][:password].present?

        params.require(:user).permit(:name, :email, :avatar, :locale, :password, :password_confirmation, role_ids: [])
      end

      def authorize_with_klass
        authorize User
      end

      def authorize_with_instance
        authorize @user
      end

      def set_breadcrumbs
        add_breadcrumb I18n.t('integral.breadcrumbs.dashboard'), :backend_dashboard_path
        add_breadcrumb I18n.t('integral.breadcrumbs.users'), :backend_users_path
      end
    end
  end
end
