module Integral
  # Backend module [Users only area]
  module Backend
    # Base controller for backend inherited by all Integral backend controllers
    class BaseController < ActionController::Base
      # Prevent CSRF attacks by raising an exception.
      # For APIs, you may want to use :null_session instead.
      protect_from_forgery with: :exception

      layout 'integral/backend'

      # User authentication
      before_action :authenticate_user!

      # User custom locale
      before_action :set_locale

      # Track user activity via paper_trail
      before_action :set_paper_trail_whodunnit

      # User authorization
      include Pundit
      rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

      layout :layout_by_resource

      private

      # Redirect user to integral dashboard after successful login
      def after_sign_in_path_for(resource)
        integral.backend_dashboard_path
      end

      # Redirect user to integral dashboard after successful logout
      def after_sign_out_path_for(resource_or_scope)
        integral.backend_dashboard_path
      end

      def user_not_authorized
        flash[:alert] = I18n.t('errors.unauthorized')
        redirect_to(backend_dashboard_path)
      end

      # Handle custom devise layouts
      # https://github.com/plataformatec/devise/wiki/How-To:-Create-custom-layouts
      # Can't do it pretty way as have no access to Application.rb within Engine (?)
      def layout_by_resource
        if devise_controller?
          "integral/login"
        else
          "integral/backend"
        end
      end

      def set_locale
        I18n.locale = current_user.locale if current_user.present?
      end

      def respond_to_record_selector(klass)
        records = klass.search(params[:search]).paginate(page: params[:page])
        render json: { content: render_to_string(partial: 'integral/backend/shared/record_selector/collection', locals: { collection: records }) }
      end

      def respond_successfully(flash_message, redirect_path)
        flash[:notice] = flash_message
        redirect_to redirect_path
      end

      def respond_failure(flash_message, template)
        flash.now[:error] = flash_message
        render template
      end
    end
  end
end
