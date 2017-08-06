class AddColumnsToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :release_date, :datetime, null: false
    add_column :movies, :genre, :string, limit: 30, null: false
  end
end
