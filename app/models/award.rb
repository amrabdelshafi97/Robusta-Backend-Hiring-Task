class Award < ApplicationRecord
  has_many :movie_awards
  has_many :movies, through: :movie_awards

  validates :award,
            length: { in: 4..50,
                      too_short: "Award title is too short",
                      too_long: "Award title is too long" },
            uniqueness: { message: "Award title is already present" },
            presence: true

end
