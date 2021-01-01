class Genre < ApplicationRecord

  validates :genre,
            length: { in: 3..20, too_short: "genre title is too short", too_long: "genre title is too long" },
            presence: true,
            uniqueness: true
end
