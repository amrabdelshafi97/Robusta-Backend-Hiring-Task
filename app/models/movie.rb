# In order to run elasticsearch you need to run these commands at Ruby console
# -- Movie.__elasticsearch__.create_index!
# -- Movie.import "If you have already data"
# also, in order to run elasticsearch server you need to run docker-compose, type in console
# -- docker-compose up -d
class Movie < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  has_many :movie_celebrities
  has_many :celebrities, through: :movie_celebrities
  has_many :movie_awards
  has_many :awards, through: :movie_awards
  has_many :movie_genres
  has_many :genres, through: :movie_genres
  has_many :watchlists
  has_many :users, through: :watchlists
  has_many :reviews
  has_many :user_movie_rates
  has_one :rate
  has_one :celebrity

  DATE_FORMAT_REGEX = /\A\d{4}\-(0?[1-9]|1[012])\-(0?[1-9]|[12][0-9]|3[01])\z/
  validates :title, presence: true, length: { in: 4..50,
                                              too_short: "Movie title is too short",
                                              too_long: "Movie title is too long" }
  validates :description, presence: true, length: { in: 10..300,
                                                    too_short: "Movie description is too short",
                                                    too_long: "Movie description is too long" }
  validates :release_date, format: { with: DATE_FORMAT_REGEX, message: "Invalid date format yyyy-mm-dd", multiline: true }, presence: true
  validates :director_id, numericality: { only_integer: true }, presence: true
  validates :film_rate_id, numericality: { only_integer: true }, presence: true
  validates :featured, inclusion: [true, false]
  validates :poster_path, presence: true
  validates :language, presence: true
  validate :director_id_is_celebrity_type_director

  def director_id_is_celebrity_type_director
    unless Celebrity.exists?(id: director_id, celebrity_type: "director")
      errors.add(:director_id, "Please add id that belongs to a director")
    end
  end

  settings do
    mappings dynamic: false do
      indexes :id, index: :not_analyzed
      indexes :title, type: :text, analyzer: :english
    end
  end

  def self.search_movie_title(query)
    search(
      query: {
        multi_match: {
          query: query,
          fields: %w[title]
        }
      },
      highlight: {
        pre_tags: ['<mark>'],
        post_tags: ['</mark>'],
        fields: {
          title: {}
        }
      })
  end
end
