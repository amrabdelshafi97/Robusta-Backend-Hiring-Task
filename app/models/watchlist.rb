class Watchlist < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates_presence_of :user, :movie
  validates :user_id, numericality: { only_integer: true, message: "Please add a valid Id" }
  validates :movie_id, numericality: { only_integer: true, message: "Please add a valid Id" }
end
