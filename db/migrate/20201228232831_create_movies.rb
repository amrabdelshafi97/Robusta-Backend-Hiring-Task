class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :description
      t.float :rating
      t.date :release_date
      t.string :rate_type

      t.timestamps
    end
  end
end
