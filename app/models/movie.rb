class Movie < ApplicationRecord
  has_many :movie_celebrities
  has_many :celebrities, through: :movie_celebrities
  has_many :movie_awards
  has_many :awards, through: :movie_awards
  has_many :movie_genres
  has_many :genres, through: :movie_genres
  has_many :watchlists
  has_many :users, through: :watchlists
  has_many :comments
  has_many :movie_rates
  has_many :rates, through: :movie_rates

  validates_presence_of :title, :description
  validates :rating, numericality: true
end
