class User < ApplicationRecord
  has_many :watchlists
  has_many :movies, through: :watchlists

  before_save { self.email = email.downcase }

  EMAIL_FORMAT_REGEX = /\A[\w-]+@([\w-]+\.)+[\w-]{2,4}\z/
  validates :username, presence: true, uniqueness: { message: "Username is already taken", case_sensitive: false }
  validates :email, presence: true, format: { with: EMAIL_FORMAT_REGEX, message: "Please enter a valid email format" },
            uniqueness: { case_sensitive: false, message: "Email is already taken" }
  validates :password, presence: true, length: { minimum: 8, message: "Please add password of minimum 8 characters" }

  has_secure_password
end
