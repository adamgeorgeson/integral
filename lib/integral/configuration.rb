module Integral
  # Handles configurable settings within Integral
  class Configuration
    attr_accessor :black_listed_paths,
                  :slack_web_hook_url,
                  :backend_namespace,
                  :blog_enabled,
                  :blog_namespace,
                  :frontend_parent_controller,
                  :editor_image_size_limit,
                  :image_thumbnail_size,
                  :image_small_size,
                  :image_medium_size,
                  :image_large_size,
                  :image_compression_quality,
                  :additional_page_templates,
                  :compression_enabled,
                  :editable_persisted_images,
                  # TODO: Change these settings to be configurable through backend
                  :facebook_app_id,
                  :twitter_handler

    def initialize
      set_defaults
    end

    # @return [Boolean] Shortcut to find out if blog is enabled
    def self.blog_enabled?
      Integral.configuration.blog_enabled
    end

    private

    def set_defaults
      @backend_namespace = 'admin'
      @blog_enabled = true
      @blog_namespace = 'blog'
      @black_listed_paths = [
        '/admin/'
      ]

      @frontend_parent_controller = "Integral::ApplicationController"

      @editor_image_size_limit = [800, 800]
      @image_compression_quality = 90
      @image_thumbnail_size = [50, 50]
      @image_small_size = [320, 320]
      @image_medium_size = [640, 640]
      @image_large_size = [1280, 1280]
      @additional_page_templates = []
      @compression_enabled = true
      @editable_persisted_images = false
    end
  end
end
