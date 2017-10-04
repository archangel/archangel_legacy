# frozen_string_literal: true

module Archangel
  class User < ApplicationRecord
    acts_as_paranoid

    before_validation :parameterize_username

    after_initialize :column_default

    after_destroy :column_reset

    devise :invitable, :confirmable, :database_authenticatable, :lockable,
           :recoverable, :registerable, :rememberable, :timeoutable, :trackable,
           :validatable
    # , :invitable

    validates :email, presence: true, uniqueness: true, email: true
    validates :name, presence: true
    validates :password, presence: true, length: { minimum: 8 }
    validates :role, presence: true, inclusion: { in: Archangel::ROLES }
    validates :username, presence: true, uniqueness: true

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
