class MovieCelebrity < ApplicationRecord
  belongs_to :movie
  belongs_to :celebrity

  validates_presence_of :celebrity, :movie
  validates :celebrity_id, numericality: { only_integer: true, message: "Please add a valid Id" }
  validates :movie_id, numericality: { only_integer: true, message: "Please add a valid Id" }

  validate celebrity_id_is_celebrity_type_actor

  def celebrity_id_is_celebrity_type_actor
    unless Celebrity.exists?(id: celebrity_id, celebrity_type: "actor")
      errors.add(:director_id, "Please add id that belongs to an actor")
    end
  end
end
