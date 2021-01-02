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
  has_many :comments
  has_many :user_movie_rates

  validates :title, presence: true, length: { in: 4..20,
                                              too_short: "Movie title is too short",
                                              too_long: "Movie title is too long" }
  validates :description, presence: true, length: { in: 10..100,
                                                    too_short: "Movie title is too short",
                                                    too_long: "Movie title is too long" }
  validates :rating, inclusion: { in: 0.0..10.0 }
  validates :release_date, format: { with: /\A\d{4}\-(0?[1-9]|1[012])\-(0?[1-9]|[12][0-9]|3[01])\z/, message: "Invalid date format yyyy-mm-dd", multiline: true }, presence: true
  validates :director_id, numericality: { only_integer: true }, presence: true
  validates :film_rate_id, numericality: { only_integer: true }, presence: true
  validates :featured, inclusion: [true, false]
  validates :poster_path, presence: true
  validates :language, presence: true

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
