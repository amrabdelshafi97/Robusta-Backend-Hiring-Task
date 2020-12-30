class Movie < ApplicationRecord
  has_many :movie_actors
  has_many :actors, through: :movie_actors
  has_many :movie_awards
  has_many :awards, through: :movie_awards
  has_many :movie_genres
  has_many :genres, through: :movie_genres
  has_many :watchlists
  has_many :users, through: :watchlists
  has_one :director

  validates_presence_of :title, :description
  validates :rating, numericality: true

  def validate
  end
end
