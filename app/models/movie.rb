class Movie < ApplicationRecord
  has_many :movie_actors
  has_many :actors, through: :movie_actors
  has_many :movie_awards
  has_many :awards, through: :movie_awards
  has_many :genres
  has_many :watchlists
  has_many :users, through: :watchlists

  validates_presence_of :title, :description

end
