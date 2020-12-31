class AddEnumColumnToCelebrities < ActiveRecord::Migration[6.1]
  def change
    def up
      execute <<-SQL
      CREATE TYPE celebrity_type AS ENUM ('celebrity', 'director');
      ALTER TABLE celebrity
      ADD COLUMN celebrity_type celebrity_type;
      SQL
    end
  end
end
