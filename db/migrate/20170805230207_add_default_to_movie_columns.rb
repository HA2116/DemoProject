class AddDefaultToMovieColumns < ActiveRecord::Migration
  def change
    change_column :movies, :featured, :boolean, default: false
    change_column :movies, :approved, :boolean, default: false
  end
end
