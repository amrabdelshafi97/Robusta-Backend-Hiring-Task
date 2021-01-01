class MovieGenre < ApplicationRecord
  belongs_to :movie
  belongs_to :genre

  validates_presence_of :genre, :movie
  validates :genre_id, numericality: { only_integer: true, message: "Please add a valid Id" }
  validates :movie_id, numericality: { only_integer: true, message: "Please add a valid Id" }
end
