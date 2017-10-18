# :nocov:
Integral.configure do |config|
  # Configure the parent controller which the blog and dynamic pages controller inherits from. Default is 'Integral::ApplicationController'
  # config.frontend_parent_controller = "::ApplicationController"

  # Configure the backend namespace. Default is 'admin'
  # config.backend_namespace = 'dashboard'

  # Configure the blog namespace. Default is 'blog'
  # config.blog_namespace = 'news'

  # Configure whether or not the blog is enabled. Default is true
  # config.blog_enabled = false

  # Manage what page templates the user has to choose from (apart from the default) when creating a page. Default is []
  # config.additional_page_templates = [:full_width]

  # Configure what page paths are protected from user entry to prevent accidentally overriding
  # config.black_listed_paths = [
  #   '/admin/',
  #   '/blog/'
  # ]

  # Configure whether or not HTML (JS, Gzip, minification, etc) compression is enabled in production. Default is true
  # config.compression_enabled = false

  # Configure the maximum dimensions of images uploaded through CKeditor
  # config.editor_image_size_limit = [800, 800]

  # Configure whether images can be re-uploaded once the record has been saved. If you're using a CDN this should be false to prevent caching issues. Default is false
  # config.editable_persisted_images = false

  # Configure image compression quality. 100 for lossless. Default is 90
  # config.image_compression_quality = 100

  # Configure the maximum dimensions of an image thumbnail version. Default is [50, 50]
  # config.image_thumbnail_size = [100, 100]

  # Configure the maximum dimensions of an image small version. Default is [320, 320]
  # config.image_thumbnail_size = [500, 500]

  # Configure the maximum dimensions of an image medium version. Default is [640, 640]
  # config.image_thumbnail_size = [800, 800]

  # Configure the maximum dimensions of an image large version. Default is [1280, 1280]
  # config.image_thumbnail_size = [1600, 1600]
end
