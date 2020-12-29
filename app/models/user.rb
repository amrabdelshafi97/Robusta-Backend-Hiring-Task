class User < ApplicationRecord
  has_many :watchlists
  has_many :movies, through: :watchlists
end
