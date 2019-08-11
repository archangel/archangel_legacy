# frozen_string_literal: true

module Archangel
  ##
  # User model
  #
  class User < ApplicationRecord
    include DeviseInvitable::Inviter

    acts_as_paranoid

    mount_uploader :avatar, Archangel::AvatarUploader

    typed_store :preferences, coder: JSON do |preference|
      preference.boolean :newsletter, default: false
      preference.datetime :preferred_at, default: Time.current, accessor: false
    end

    before_validation :parameterize_username

    after_initialize :column_default

    after_destroy :column_reset

    devise :confirmable, :database_authenticatable, :invitable, :lockable,
           :recoverable, :registerable, :rememberable, :timeoutable, :trackable,
           :validatable

    validates :avatar, file_size: {
      less_than_or_equal_to: Archangel.config.image_maximum_file_size
    }
    validates :email, email: { message: Archangel.t(:email_invalid) },
                      uniqueness: { scope: :site_id }

    validates :name, presence: true
    validates :role, presence: true, inclusion: { in: Archangel::ROLES }
    validates :username, presence: true, uniqueness: { scope: :site_id }

    validates :newsletter, inclusion: { in: [true, false] }

    belongs_to :site

    ##
    # Only send the password reset email if the invitation has been accepted
    #
    def send_reset_password_instructions
      super if invitation_token.blank?
    end

    ##
    # Overwrite resource id to `username`
    #
    # @return [String] the aliased resource param
    #
    def to_param
      username
    end

    protected

    def parameterize_username
      self.username = username.to_s.downcase.parameterize
    end

    def column_default
      self.role ||= Archangel::ROLE_DEFAULT
    end

    def column_reset
      now = Time.current.to_i

      self.email = "#{now}_#{email}"
      self.username = "#{now}_#{username}"

      save
    end
  end
end
