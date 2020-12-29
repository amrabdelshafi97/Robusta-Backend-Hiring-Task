class CreateNews < ActiveRecord::Migration[6.1]
  def change
    create_table :news do |t|
      t.string :title
      t.string :description
      t.date :date
      t.string :content

      t.timestamps
    end
  end
end
