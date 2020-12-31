class CreateCelebrities < ActiveRecord::Migration[6.1]
  def change
    create_table :celebrity do |t|
      t.text :display_name, :first_name, :last_name, null: false
      t.date :birthdate, null: false
      t.date :deathdate
      t.text :gender, :nationality, :biography, null: false

      t.timestamps
    end
  end
end
