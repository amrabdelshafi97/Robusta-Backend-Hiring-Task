class MovieAward < ApplicationRecord
  belongs_to :movie
  belongs_to :award

  validates_presence_of :award, :movie
  validates :award_id, numericality: { only_integer: true, message: "Please add a valid Id" }
  validates :movie_id, numericality: { only_integer: true, message: "Please add a valid Id" }
end
