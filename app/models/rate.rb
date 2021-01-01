class Rate < ApplicationRecord
  validates :genre,
            presence: true,
            uniqueness: true,
            inclusion: { in: %w(G P PG-13 R NC-17),
                         message: "Please enter a valid type (G/P/PG-13/R/NC-17)" }

end
