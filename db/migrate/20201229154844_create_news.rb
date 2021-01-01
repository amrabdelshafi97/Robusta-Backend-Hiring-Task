class CreateNews < ActiveRecord::Migration[6.1]
  def change
    create_table :news do |t|
      t.text :title, :description, :content, null: false

      t.timestamps
    end
  end
end
