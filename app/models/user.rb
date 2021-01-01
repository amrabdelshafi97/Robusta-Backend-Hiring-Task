class User < ApplicationRecord
  has_many :watchlists
  has_many :movies, through: :watchlists

  validates :username, presence: true, uniqueness: { message: "Username is already taken" }
  validates :email, presence: true, format: { with: /^[\w-]+@([\w-]+\.)+[\w-]{2,4}$/, message: "Please enter a valid email format" }, uniqueness: { message: "Email is already taken" }
  validates :password, presence: true, length: { minimum: 8, message: "Please add password of minimum 8 characters" }
end
