module Integral
  # Represents a user post
  class Post < ActiveRecord::Base
    include ActionView::Helpers::DateHelper
    acts_as_paranoid # Soft-deletion
    acts_as_listable if Configuration.blog_enabled? # Listable Item
    acts_as_taggable # Tagging

    # Slugging
    extend FriendlyId
    friendly_id :title, use: :history

    enum status: [ :draft, :published ]

    # Conditional is hack to check if method exists otherwise causes undefined method error in test env
    self.per_page = 8 if self.respond_to? :per_page

    # Associations
    belongs_to :user
    belongs_to :image, class_name: Integral::Image

    # Validations
    validates :title, presence: true, length: { minimum: 4, maximum: 50 }
    validates :description, presence: true, length: { minimum: 50, maximum: 160 }
    validates :body, :user, :slug, presence: true

    # Callbacks
    before_save :set_published_at

    # Aliases
    alias_method :author, :user

    # Scopes
    scope :search, -> (query) { where("lower(title) LIKE ?", "%#{query.downcase}%") }

    # @return [Array] containing available human readable statuses against there numeric value
    def self.available_statuses(opts={ reverse: false })
      statuses = [
        [I18n.t('integral.backend.users.status.draft'), :draft],
        [I18n.t('integral.backend.users.status.published'), :published]
      ]

      statuses.each(&:reverse!) if opts[:reverse]
    end

    # Increments the view count of the post if a PostViewing is successfully added
    #
    # @param ip_address [String] Viewers IP address
    def increment_count!(ip_address)
      increment!(:view_count) if PostViewing.add(self, ip_address)
    end

    # @return [Hash] the instance as a list item
    def to_list_item
      subtitle = self.published_at.present? ? I18n.t('integral.blog.posted_ago', time: time_ago_in_words(self.published_at)) : I18n.t('integral.users.status.draft')
      image_url = image.file.url if image
      {
        id: id,
        title: title,
        subtitle: subtitle,
        description: description,
        image: image_url,
        url: Integral::Engine.routes.url_helpers.post_url(self)
      }
    end

    # @return [Hash] listable options to be used within a RecordSelector widget
    def self.listable_options
      {
        record_title: I18n.t('integral.backend.record_selector.posts.record'),
        selector_path: Engine.routes.url_helpers.backend_posts_path,
        selector_title: I18n.t('integral.backend.record_selector.posts.title')
      }
    end

    private

    def set_slug
      self.slug = resolve_friendly_id_conflict([self.slug]) if slug_changed? && Post.exists_by_friendly_id?(self.slug)
    end

    def set_published_at
      self.published_at = Time.now if self.published? && self.published_at.nil?
    end

    # Override CarrierwaveBackgrounder Method
    # CarrierwaveBackgrounder should not be attempting to processing images when processing is disabled through Carrierwave
    def enqueue_image_background_job?
      !remove_image? && !process_image_upload && image_updated? && PostImageUploader.enable_processing
    end
  end
end
