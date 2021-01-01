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
  has_many :movie_rates
  has_many :rates, through: :movie_rates

  validates_presence_of :title, :description
  validates :rating, numericality: true

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
