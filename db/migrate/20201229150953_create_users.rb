class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.text :username, :email, :password_digest, null: false, unique: true
      t.index :email, unique: true

      t.timestamps
    end
  end
end
