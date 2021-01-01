class CreateMovieAwards < ActiveRecord::Migration[6.1]
  def change
    create_table :movie_awards do |t|
      t.references :movie, null: false, foreign_key: true
      t.references :award, null: false, foreign_key: true

      t.timestamps
    end
    add_index :movie_awards, [:movie_id, :award_id], unique: true

  end
end
