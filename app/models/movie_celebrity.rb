class MovieCelebrity < ApplicationRecord
  belongs_to :movie
  belongs_to :celebrity

  validates_presence_of :celebrity, :movie
  validates :celebrity_id, numericality: { only_integer: true, message: "Please add a valid Id" }
  validates :movie_id, numericality: { only_integer: true, message: "Please add a valid Id" }
end
