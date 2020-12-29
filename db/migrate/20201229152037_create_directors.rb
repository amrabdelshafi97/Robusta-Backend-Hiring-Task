class CreateDirectors < ActiveRecord::Migration[6.1]
  def change
    create_table :directors do |t|
      t.string :display_name
      t.string :first_name
      t.string :last_name
      t.date :birthdate
      t.date :deathdate
      t.string :biography
      t.string :place_of_birth

      t.timestamps
    end
  end
end
