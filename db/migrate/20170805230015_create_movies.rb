class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.text :description
      t.string :trailer
      t.boolean :featured
      t.boolean :approved

      t.timestamps null: false
    end
  end
end
