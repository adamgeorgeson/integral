$:.push File.expand_path("../lib", __FILE__)

require "integral/version"

Gem::Specification.new do |s|
  s.name        = "integral"
  s.version     = Integral::VERSION
  s.authors     = ["Patrick Lindsay"]
  s.email       = ["ptricklindsay@gmail.com"]
  s.homepage    = "https://github.com/patricklindsay/integral"
  s.summary     = "This gem packages together a variety of useful features and utilities integral for the foundation of any website or application."
  s.description = "Integral packages together all the basics to start a website or application so you don't have to.."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md", "spec/factories.rb", "spec/support/image.jpg"]

  s.add_dependency "rails", "~> 4.2"
  s.add_dependency "turbolinks", "~> 5.0"
  s.add_dependency "nprogress-rails", "~> 0.2.0"
  s.add_dependency "devise", "~> 4.2" # Authentication
  s.add_dependency "devise_invitable", "~> 1.7" # Invitable authentication
  s.add_dependency "pundit", "~> 1.1" # Authorization
  s.add_dependency "haml-rails", "~> 0.9" # HAML
  s.add_dependency "sass-rails", "~> 5.0" # Sass
  s.add_dependency "materialize-sass", '~> 0.97.5.0' # Material Design UI framework
  s.add_dependency "foundation-rails", "~> 6.2.1" # Foundation UI Framework
  s.add_dependency "simple_form", "~> 3.3" # Form builder
  s.add_dependency "cocoon", "~> 1.2" # Nested forms
  s.add_dependency "draper", "~> 2.1" # Object decoration
  s.add_dependency "paranoia", "~> 2.0" # Soft-delete records
  s.add_dependency "client_side_validations", "~> 4.2" # Client-side validations
  s.add_dependency "client_side_validations-simple_form", "~> 3.3" # Simpleform integration for Client-side validations
  s.add_dependency "parsley-rails", "~> 2.4.4" # Jquery form validation plugin
  s.add_dependency "wice_grid", "~> 3.6" # Grids
  s.add_dependency "will_paginate", "~> 3.1" # Pagination
  s.add_dependency "will_paginate-foundation", "~> 6.2" # Pagination for Foundation
  s.add_dependency "font-awesome-sass", '~> 4.3' # Grid Icons
  s.add_dependency "breadcrumbs_on_rails", "~> 3.0" # Breadcrumbs
  s.add_dependency "carrierwave", "~> 1.0" # File uploader - Careful when upgrading. Make sure overrides still work in Integral::ImageUploader
  s.add_dependency "carrierwave-imageoptimizer", "~> 1.4" # Image compression
  s.add_dependency "carrierwave_backgrounder" #, "~> 0.4" # Delayed image processing
  s.add_dependency "ckeditor", "= 4.2.0" # WYSIWYG Editor
  s.add_dependency "slack-notifier", "~> 1.5" # Slack bot
  s.add_dependency "mini_magick", "~> 4.6" # File manipulation
  s.add_dependency "friendly_id", "~> 5.2" # Slugging
  s.add_dependency "meta-tags", "~> 2.4" # Meta Tag Management (SEO)
  s.add_dependency "gaffe", "~> 1.2" # Custom error pages
  s.add_dependency "rails4_before_render", "~> 0.2" # Callbacks after an action before rendering
  s.add_dependency "acts-as-taggable-on", '~> 3.4' # Tagging
  s.add_dependency "i18n-js", "~> 3.0.0.rc15" # Clientside translations
  s.add_dependency "htmlcompressor", "~> 0.2.0" # Compression

  s.add_dependency 'factory_girl_rails', "~> 4.7" # Create reusable object templates
  s.add_dependency 'faker', "~> 1.6" # Random data generator
  s.add_dependency "rails-settings-cached", "~> 0.6" # Persisted settings

  s.add_development_dependency "pry-rails", "~> 0.3" # Debugger
  s.add_development_dependency "sqlite3", "~> 1.3" # Database
  s.add_development_dependency 'rspec-rails', "~> 3.5" # Testing framework
  s.add_development_dependency 'database_cleaner', "~> 1.5" # Manages database for consistent data setup
  s.add_development_dependency 'shoulda-matchers', "~> 3.1" # Extra matchers for testing
  s.add_development_dependency 'faker', "~> 1.6" # Random data generator
  s.add_development_dependency 'capybara', "~> 2.10" # Acceptance testing framework
  s.add_development_dependency 'poltergeist', "~> 1.11" # Headless driver for Capybara which supports JS
  s.add_development_dependency 'launchy', "~> 2.4" # Automatically launch test pages

  # CI, code coverage, analysis and documentation tools
  s.add_development_dependency 'fudge', "~> 0.6.3" # Build tool
  s.add_development_dependency 'brakeman', "~> 3.4" # Static security
  s.add_development_dependency 'cane', "~> 3.0" # Line length
  s.add_development_dependency 'flog', "~> 4.4"  # Complexity
  s.add_development_dependency 'flay', "~> 2.8" # Duplication
  s.add_development_dependency 'ruby2ruby', "~> 2.2" # Ruby diff tool
  s.add_development_dependency 'yard', "~> 0.9.5" # Documentation
  s.add_development_dependency 'simplecov', "~> 0.12" # Coverage
end
