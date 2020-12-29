class Movie < ApplicationRecord
  has_many :movie_actors
  has_many :actors, through: :movie_actors

  validates_presence_of :title, :description

end
