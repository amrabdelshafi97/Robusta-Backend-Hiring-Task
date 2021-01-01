class AddGenderType < ActiveRecord::Migration[6.1]
  def change
    execute <<-SQL
      CREATE TYPE gender AS ENUM ('male', 'female');
      ALTER TABLE celebrities
      ADD COLUMN gender gender;
    SQL
  end
end
