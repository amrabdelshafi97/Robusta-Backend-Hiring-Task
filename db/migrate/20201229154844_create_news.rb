class CreateNews < ActiveRecord::Migration[6.1]
  def change
    create_table :news do |t|
      t.text :title, :description, null: false
      t.date :date, null: false
      t.text :content, null: false

      t.timestamps
    end
  end
end
