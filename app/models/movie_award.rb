class MovieAward < ApplicationRecord
  belongs_to :movie
  belongs_to :award

  validates_presence_of :award, :movie
end
