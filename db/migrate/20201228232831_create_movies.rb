class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.text :title, null: false
      t.text :description, null: false
      t.float :rating, default: 0.0
      t.date :release_date, null: false
      t.integer :director_id, null: false
      t.integer :film_rate_id, null: false
      t.boolean :featured, default: false
      t.text :poster_path, null: false
      t.text :language

      t.timestamps
    end
  end
end
