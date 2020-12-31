class MovieCelebrity < ApplicationRecord
  belongs_to :movie
  belongs_to :celebrity

  validates_presence_of :actor, :movie
end
