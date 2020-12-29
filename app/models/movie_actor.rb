class MovieActor < ApplicationRecord
  belongs_to :movie
  belongs_to :actor

  validates_presence_of :actor, :movie
end
