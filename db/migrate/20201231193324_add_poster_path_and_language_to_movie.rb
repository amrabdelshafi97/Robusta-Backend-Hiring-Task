class AddPosterPathAndLanguageToMovie < ActiveRecord::Migration[6.1]
  def change
    add_column :movies, :poster_path, :string
    add_column :movies, :language, :string
  end
end
