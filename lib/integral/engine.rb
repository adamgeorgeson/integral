module Integral
  # Integral Engine
  class Engine < ::Rails::Engine
    require 'haml'
    require 'htmlcompressor'
    require 'jquery-rails'
    require 'turbolinks'
    require 'nprogress-rails'
    require 'simple_form'
    require 'cocoon'
    require 'draper'
    require 'client_side_validations'
    require 'client_side_validations/simple_form'
    require 'parsley-rails'
    require 'wice_grid'
    require 'font-awesome-sass'
    require 'breadcrumbs_on_rails'
    require 'materialize-sass'
    require 'foundation-rails'
    require 'materialize_builder'
    require 'pundit'
    require 'carrierwave'
    require 'carrierwave_backgrounder'
    require 'carrierwave-imageoptimizer'
    require 'ckeditor'
    require 'i18n-js'
    require 'meta-tags'
    require 'before_render'
    require 'friendly_id'
    require 'acts-as-taggable-on'
    require 'slack-notifier'
    require 'paranoia'
    require 'will_paginate'
    require 'will_paginate-foundation'
    require 'rails-settings-cached'
    require 'gaffe'

    isolate_namespace Integral

    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end

    # Engine customization
    config.to_prepare do
      # Load WiceGrid overrides for standard datepicker
      require Integral::Engine.root + 'lib/wice/columns/column_bootstrap_datepicker.rb'
      require Integral::Engine.root + 'lib/wice/helpers/bs_calendar_helpers.rb'

      # Allow Integral to be extended
      Dir.glob(Rails.root + "app/extensions/**/*_decorator*.rb").each do |c|
        require_dependency(c)
      end

      Integral::Engine.routes.default_url_options[:host] = Rails.application.routes.default_url_options[:host]
    end

    # Clientside I18n
    config.assets.initialize_on_precompile = true

    # Allows engine factories to be reused by application
    initializer "model_core.factories", :after => "factory_girl.set_factory_paths" do
      FactoryGirl.definition_file_paths << File.expand_path('../../../spec/factories', __FILE__) if defined?(FactoryGirl)
    end

    initializer "integral.assets.precompile" do |app|
      assets_for_precompile = [
        # Dashboard tiles
        "integral/tiles/*",
        # Defaults
        "integral/defaults/*",
        # CKEditor Overrides
        "ckeditor/my_contents.css",
        "ckeditor/my_styles.js",
        "ckeditor/my_config.js",
        "ckeditor/filebrowser/*",
        "ckeditor/skins/*",
        "ckeditor/plugins/*",

        # Frontend
        "integral/frontend.js",
        "integral/frontend.css",

        # Backend
        "integral/backend.js",
        "integral/backend.css",
        "integral/image-not-set.png",

        # Errors
        "errors.css"
      ]

      app.config.assets.precompile.concat assets_for_precompile
    end
  end
end
