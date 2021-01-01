class AddEnumColumnToNews < ActiveRecord::Migration[6.1]
  def change
    execute <<-SQL
      CREATE TYPE permission_type AS ENUM ('admin', 'user');
      ALTER TABLE news
      ADD COLUMN posted_by permission_type;
    SQL

  end
end
