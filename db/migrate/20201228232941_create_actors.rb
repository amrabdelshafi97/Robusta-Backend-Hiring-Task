class CreateActors < ActiveRecord::Migration[6.1]
  def change
    create_table :actors do |t|
      t.string :display_name
      t.string :first_name
      t.string :last_name
      t.date :birthdate

      t.timestamps
    end
  end
end
