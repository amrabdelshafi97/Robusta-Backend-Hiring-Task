class Celebrity < ApplicationRecord
  has_many :movie_celebrities
  has_many :movies, through: :movie_celebrities

  #validates_presence_of :display_name
end
