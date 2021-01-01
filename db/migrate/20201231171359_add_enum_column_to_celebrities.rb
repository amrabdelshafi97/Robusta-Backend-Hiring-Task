class AddEnumColumnToCelebrities < ActiveRecord::Migration[6.1]
  def change
    execute <<-SQL
      CREATE TYPE celebrity_type AS ENUM ('actor', 'director');
      ALTER TABLE celebrities
      ADD COLUMN celebrity_type celebrity_type NOT NULL;
    SQL
  end
end
