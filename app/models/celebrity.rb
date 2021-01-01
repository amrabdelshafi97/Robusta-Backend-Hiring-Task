# In order to run elasticsearch you need to run these commands at Ruby console
# -- Celebrity.__elasticsearch__.create_index!
# -- Celebrity.import "If you have already data"
# also, in order to run elasticsearch server you need to run docker-compose, type in console
# -- docker-compose up -d
class Celebrity < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  has_many :movie_celebrities
  has_many :movies, through: :movie_celebrities

  settings do
    mappings dynamic: false do
      indexes :id, index: :not_analyzed
      indexes :display_name, type: :text, analyzer: :english
    end
  end

  def self.search_movie_title(query)
    search(
      query: {
        multi_match: {
          query: query,
          fields: %w[display_name]
        }
      },
      highlight: {
        pre_tags: ['<mark>'],
        post_tags: ['</mark>'],
        fields: {
          display_name: {}
        }
      })
  end
end
