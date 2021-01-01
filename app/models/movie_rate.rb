class MovieRate < ApplicationRecord
  belongs_to :rate
  belongs_to :movie
end
