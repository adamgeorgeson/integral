module Integral
  module Backend
    # Pages controller
    class PagesController < BaseController
      before_filter :set_page, only: [:edit, :update, :destroy]
      before_filter :authorize_with_klass, only: [ :index, :new, :create, :edit, :update, :destroy ]
      before_filter :set_breadcrumbs

      # GET /
      # Lists all pages
      def index
        respond_to do |format|
          format.html do
            @pages_grid = initialize_grid(Page)

            @published_pages_count = Integral::Page.published.count
            @draft_pages_count = Integral::Page.draft.count
          end

          format.json do
            respond_to_record_selector(Integral::Page)
          end
        end
      end

      # GET /new
      # Page creation form
      def new
        add_breadcrumb I18n.t('integral.breadcrumbs.new'), :new_backend_page_path
        @page = Page.new
      end

      # POST /
      # Page creation
      def create
        @page = Page.new(page_params)

        if @page.save
          respond_successfully(I18n.t('integral.backend.pages.notification.creation_success'), edit_backend_page_path(@page))
        else
          respond_failure(I18n.t('integral.backend.pages.notification.creation_failure'), :new)
        end
      end

      # GET /:id/edit
      # Page edit form
      def edit
        add_breadcrumb I18n.t('integral.breadcrumbs.edit'), :edit_backend_page_path
      end

      # PUT /:id
      # Updating an page
      def update
        if @page.update(page_params)
          respond_successfully(I18n.t('integral.backend.pages.notification.edit_success'), edit_backend_page_path(@page))
        else
          respond_failure(I18n.t('integral.backend.pages.notification.edit_failure'), :edit)
        end
      end

      # DELETE /:id
      def destroy
        if @page.destroy
          respond_successfully(I18n.t('integral.backend.pages.notification.delete_success'), backend_pages_path)
        else
          error_message = @page.errors.full_messages.to_sentence
          flash[:error] = "#{I18n.t('integral.backend.pages.notification.delete_failure')} - #{error_message}"
          redirect_to backend_pages_path
        end
      end

      private

      def authorize_with_klass
        authorize Page
      end

      def set_page
        @page = Page.find(params[:id])
      end

      def page_params
        params.require(:page).permit(:title, :description, :path, :body, :status, :template, :parent_id)
      end

      def set_breadcrumbs
        add_breadcrumb I18n.t('integral.breadcrumbs.dashboard'), :backend_dashboard_path
        add_breadcrumb I18n.t('integral.breadcrumbs.pages'), :backend_pages_path
      end
    end
  end
end
