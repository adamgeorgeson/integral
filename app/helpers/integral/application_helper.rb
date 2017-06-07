module Integral
  # Base helper inherited from all Integral helpers
  module ApplicationHelper

    # Combines Twitter base URL and configurable handler to output full Twitter URL
    #
    # @return [String] Twitter URL
    def twitter_url
      "https://www.twitter.com/#{Settings.twitter_handler}"
    end

    # Combines Facebook base URL and configurable handler to output full Facebook URL
    #
    # @return [String] Facebook URL
    def facebook_url
      "https://www.facebook.com/#{Settings.facebook_handler}"
    end

    # TODO: Could look to move this out into seperate helper class
    def google_tag_manager(type=:script)
      gtm_id = Settings.google_tag_manager_id
      return if gtm_id.blank? || !Rails.env.production?

      if type == :script
        snippet = <<-HTML
        <!-- Google Tag Manager -->
        <script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
        new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
        j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
        '//www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
        })(window,document,'script','dataLayer','#{gtm_id}');</script>
        <!-- End Google Tag Manager -->
        HTML
      else
        snippet = <<-HTML
        <!-- Google Tag Manager -->
        <noscript><iframe src="//www.googletagmanager.com/ns.html?id=#{gtm_id}"
          height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
        <!-- End Google Tag Manager -->
        HTML
      end

      snippet.html_safe
    end

    # @return [String] Configurable Website title
    def site_title
      Settings.website_title
    end

    # Creates an anchor link
    #
    # @param body [String] body of the link
    # @param location [String] location of the anchor
    #
    # @return [String] anchor to a particular location of the current page
    def anchor_to(body, location)
      current_path = url_for(:only_path => false)
      path = "#{current_path}##{location}"

      link_to body, path
    end

    # @return [String] markup listing flashes
    def render_flashes
      flash_types = [:notice, :alert, :error]

      content_tag :div, id: :flash_list do
        flash_types.each do |type|
          concat render_flash(type, flash[type]) if flash[type].present?
        end
      end
    end

    # @return [Array] localised true and false to be used in dropdowns
    def boolean_select_options
      [
        [I18n.t('integral.boolean.true'), 'true'],
        [I18n.t('integral.boolean.false'), 'false']
      ]
    end

    # Renders icon link
    #
    # @param [String] icon to use
    # @param [String] url to link to
    # @param [Hash] html_options to pass through to link_to helper
    #
    def icon_link_to(icon, url, html_options={})
      icon_classes = html_options.delete(:icon_classes)
      icon_text = html_options.delete(:text)

      icon_classes = 'left' if icon_classes.blank?
      link_to "<i class='material-icons #{icon_classes}'>#{icon}</i>#{icon_text}".html_safe, url, html_options
    end

    # Override method_missing to check for main app routes before throwing exception
    def method_missing method, *args, &block
      if method.to_s.end_with?('_path') or method.to_s.end_with?('_url')
        if main_app.respond_to?(method)
          main_app.send(method, *args)
        else
          super
        end
      else
        super
      end
    end

    # Override respond_to? to check for main app routes
    def respond_to?(method, include_all=false)
      if method.to_s.end_with?('_path') or method.to_s.end_with?('_url')
        if main_app.respond_to?(method)
          true
        else
          super
        end
      else
        super
      end
    end

    private

    def render_flash(type, message)
      content_tag(:div, nil, class: :flash, data: { message: message, klass: type })
    end
  end
end
