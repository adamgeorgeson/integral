module Integral
  # Renders dynamic pages
  class PagesController < Integral.configuration.frontend_parent_controller.constantize
    before_filter :find_page, only: [:show]
    before_filter :set_breadcrumbs

    # GET /{page.path}
    # Presents dynamic pages
    def show
      @meta_data = {
        page_title: @page.title,
        page_description: @page.description,
        # TODO: Allow users to link images to a Page
        open_graph:  {
        }
      }

      render "integral/pages/templates/#{@page.template}"
    end

    private

    def find_page
      if current_user.present?
        @page = Integral::Page.find(params[:id]).decorate
      else
        @page = Integral::Page.published.find(params[:id]).decorate
      end

      @page.decorate
    end

    def set_breadcrumbs
      add_breadcrumb I18n.t('header.navigation.home'), :root_url

      @page.breadcrumbs.each do |breadcrumb|
        add_breadcrumb breadcrumb[:title], "#{Rails.application.routes.default_url_options[:host]}#{breadcrumb[:path]}"
      end
    end
  end
end
