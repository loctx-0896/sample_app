class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  before_save{email.downcase!}
  has_secure_password
  validates :name, presence: true,
            length: {maximum: Settings.users.name.maximum}
  validates :email, presence: true,
            length: {maximum: Settings.users.email.maximum},
            format: {with: VALID_EMAIL_REGEX},
            uniqueness: {case_sensitive: false}
  validates :password, presence: true,
            length: {minimum: Settings.users.password.minimum}
end
