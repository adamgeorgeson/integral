module Integral
  # Represents a user post
  class Post < ActiveRecord::Base
    # Soft-deletion
    acts_as_paranoid

    # Slugging
    extend FriendlyId
    friendly_id :title, use: :history

    acts_as_taggable

    mount_uploader :image, PostImageUploader

    enum status: [ :draft, :published ]

    # Conditional is hack to check if method exists otherwise causes undefined method error in test env
    self.per_page = 8 if self.respond_to? :per_page

    # Associations
    belongs_to :user

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
        [I18n.t('integral.users.status.draft'), :draft],
        [I18n.t('integral.users.status.published'), :published]
      ]

      statuses.each(&:reverse!) if opts[:reverse]
    end

    # Increments the view count of the post if a PostViewing is successfully added
    #
    # @param ip_address [String] Viewers IP address
    def increment_count!(ip_address)
      increment!(:view_count) if PostViewing.add(self, ip_address)
    end

    def to_list_item
      {
        id: id,
        title: title,
        subtitle: 'TODO',
        description: description,
        image: image.url,
        url: 'Override me'
        #url: Rails.application.routes.url_helpers.blog_path(self)
      }
    end

    def self.listable_options
      {
        record_title: 'Post',
        selector_path: Engine.routes.url_helpers.posts_path,
        selector_title: 'Select a Post..'
      }
    end

    private

    def set_slug
      self.slug = resolve_friendly_id_conflict([self.slug]) if slug_changed? && Post.exists_by_friendly_id?(self.slug)
    end

    def set_published_at
      self.published_at = Time.now if self.published? && self.published_at.nil?
    end
  end
end