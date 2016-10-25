module Integral
  class List < ActiveRecord::Base
    # Associations
    has_many :list_items

    # Validations
    validates :title, presence: true

    before_destroy :validate_unlocked

    # Nested forms
    accepts_nested_attributes_for :list_items, reject_if: :all_blank, allow_destroy: true

    private

    def validate_unlocked
      if locked?
        errors.add(:locked, "Cannot delete a locked item")
        return false
      end
    end
  end
end