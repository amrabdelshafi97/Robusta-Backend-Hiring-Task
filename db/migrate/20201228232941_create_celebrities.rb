class CreateCelebrities < ActiveRecord::Migration[6.1]
  def change
    create_table :celebrities do |t|
      t.text :display_name, :first_name, :last_name, null: false
      t.date :birthdate, null: false
      t.date :deathdate
      t.text :gender, :nationality, :biography, null: false
      t.text :place_of_birth, null: false

      t.timestamps
    end
  end
end
