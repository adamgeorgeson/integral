module Integral
  # User model used to represent a authenticated user
  class User < ActiveRecord::Base
    # Soft-deletion
    acts_as_paranoid

    mount_uploader :avatar, AvatarUploader
    process_in_background :avatar

    # Included devise modules. Others available are:
    # :confirmable, :timeoutable, :omniauthable, registerable and lockable
    devise :invitable, :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

    # Relations
    has_many :role_assignments
    has_many :roles, :through => :role_assignments

    # Validations
    validates :name, :email, presence: true
    validates :name, length: { minimum: 3, maximum: 25 }

    has_paper_trail class_name: 'Integral::UserVersion'

    # Checks if the User has a given role
    #
    # @param role_sym [Symbol] role to check
    #
    # @return [Boolean]
    def has_role?(role_sym)
      roles.any? { |r| r.name.underscore.to_sym == role_sym }
    end

    # @return [Array] containing available locales
    def self.available_locales
      [
        ['English', 'en'],
        ['日本語', 'ja']
      ]
    end

    # @return [String] return the avatar filename
    def avatar_filename
      name
    end

    private

    def send_devise_notification(notification, *args)
      devise_mailer.send(notification, self, *args).deliver_later
    end
  end
end
