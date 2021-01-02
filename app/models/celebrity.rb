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

  DATE_FORMAT_REGEX = /\A\d{4}\-(0?[1-9]|1[012])\-(0?[1-9]|[12][0-9]|3[01])\z/

  validates :display_name, length: { in: 3..20, message: "Name length not valid" }, presence: true
  validates :first_name, length: { in: 3..10, message: "Name length not valid" }, presence: true
  validates :last_name, length: { in: 3..10, message: "Name length not valid" }, presence: true
  validates :biography, length: { maximum: 300, too_long: "Bio characters count is the maximum allowed" }
  validates :birthdate, format: { with: DATE_FORMAT_REGEX, message: "Invalid date format yyyy-mm-dd" }, presence: true
  validates :deathdate, format: { with: DATE_FORMAT_REGEX, message: "Invalid date format yyyy-mm-dd" }
  validates :nationality, presence: true
  validates :place_of_birth, presence: true
  validates :celebrity_type, inclusion: { in: %w(actor director), message: "Please enter a valid type (actor/director)" }, presence: true
  validates :gender, inclusion: { in: %w(male female), message: "Please enter a valid type (male/female)" }, presence: true

  settings do
    mappings dynamic: false do
      indexes :id, index: :not_analyzed
      indexes :display_name, type: :text, analyzer: :english
    end
  end

  def self.search_celebrity(query)
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
