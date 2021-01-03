class Review < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates :review, length: { in: 4..20, too_short: "comment is too short", too_long: "comment is too long" }, presence: true
end
