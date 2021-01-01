class MovieCelebrity < ApplicationRecord
  belongs_to :movie
  belongs_to :celebrity
end
