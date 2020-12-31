class CreateRates < ActiveRecord::Migration[6.1]
  def change
    create_table :rates do |t|
      t.text :rate, null: false

      t.timestamps
    end
  end
end
