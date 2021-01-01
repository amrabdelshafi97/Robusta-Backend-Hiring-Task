class CreateUserMovieRates < ActiveRecord::Migration[6.1]
  def change
    create_table :user_movie_rates do |t|
      t.references :user, null: false, foreign_key: true
      t.references :movie, null: false, foreign_key: true
      t.float :rate

      t.timestamps
    end
    add_index :user_movie_rates, [:user_id, :movie_id], unique: true
  end
end
