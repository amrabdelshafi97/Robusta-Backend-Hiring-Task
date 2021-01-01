class CreateMoviesCelebrities < ActiveRecord::Migration[6.1]
  def change
    create_table :movie_celebrities do |t|
      t.references :movie, null: false, foreign_key: true
      t.references :celebrity, null: false, foreign_key: true

      t.timestamps
    end
    add_index :movie_celebrities, [:movie_id, :celebrity_id], unique: true
  end
end
