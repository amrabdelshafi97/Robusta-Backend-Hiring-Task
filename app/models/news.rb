# In order to run elasticsearch you need to run these commands at Ruby console
# -- News.__elasticsearch__.create_index!
# -- News.import "If you have already data"
# also, in order to run elasticsearch server you need to run docker-compose, type in console
# -- docker-compose up -d
class News < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  settings do
    mappings dynamic: false do
      indexes :id, index: :not_analyzed
      indexes :content, type: :text, analyzer: :english
    end
  end
  
  def self.search_news_content(query)
    search(
      query: {
        multi_match: {
          query: query,
          fields: %w[content]
        }
      },
      highlight: {
        pre_tags: ['<mark>'],
        post_tags: ['</mark>'],
        fields: {
          content: {}
        }
      })
  end
end
