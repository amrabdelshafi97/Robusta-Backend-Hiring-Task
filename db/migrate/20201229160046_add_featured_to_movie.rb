class AddFeaturedToMovie < ActiveRecord::Migration[6.1]
  def change
    add_column :movies, :featured, :boolean
  end
end
