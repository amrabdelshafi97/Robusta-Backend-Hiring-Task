# In order to run elasticsearch you need to run these commands at Ruby console
# -- News.__elasticsearch__.create_index!
# -- News.import "If you have already data"
# also, in order to run elasticsearch server you need to run docker-compose, type in console
# -- docker-compose up -d
class News < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  validates :title, presence: true, length: { in: 4..20,
                                              too_short: "Award title is too short",
                                              too_long: "Award title is too long" }
  validates :subtitle, presence: true, length: { in: 10..100,
                                                 too_short: "News description is too short",
                                                 too_long: "News description is too long" }
  validates :content, presence: true, length: { minimum: 50, message: "Please create content Of minimum length 50 characters" }
  validates :posted_by, presence: true, numericality: { only_integer: true, message: "Please add a valid Id" }

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
