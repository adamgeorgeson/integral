module Integral
  # Represents a generic list such as a gallery or menu
  class List < ActiveRecord::Base
    default_scope { includes(:list_items) }

    # Associations
    has_many :list_items

    # Validations
    validates :title, presence: true, uniqueness: true

    before_destroy :validate_unlocked

    # Nested forms
    accepts_nested_attributes_for :list_items, reject_if: :all_blank, allow_destroy: true

    has_paper_trail class_name: 'Integral::ListVersion'

    # Duplicates the list including all attributes, list items and list item children
    #
    # @return [List] Unsaved cloned list
    def dup(title='')
      new_list = super()
      new_list.title = title if title.present?

      list_items.each do |list_item|
        new_list_item = list_item.dup

        if list_item.has_children?
          list_item.children.each do |child|
            new_list_item.children << child.dup
          end
        end

        new_list.list_items << new_list_item
      end

      new_list
    end

    private

    def validate_unlocked
      return unless locked?

      errors.add(:locked, "Cannot delete a locked item")
      false
    end
  end
end
