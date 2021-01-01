class UserMovieRate < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates :user_id, numericality: { only_integer: true, message: "Please add a valid Id" }
  validates :movie_id, numericality: { only_integer: true, message: "Please add a valid Id" }
  validates :rate, numericality: { only_integer: true,
                                   greater_than_or_equal_to: 0,
                                   less_than_or_equal_to: 10,
                                   message: "Please add rate in range from 0 to 10" }
end
