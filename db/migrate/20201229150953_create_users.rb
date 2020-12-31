class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.text :username, :email, :password, null: false
      t.index :email, unique: true

      t.timestamps
    end
  end
end
