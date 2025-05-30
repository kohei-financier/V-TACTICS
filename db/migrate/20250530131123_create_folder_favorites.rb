class CreateFolderFavorites < ActiveRecord::Migration[7.2]
  def change
    create_table :folder_favorites do |t|
      t.references :folder, null: false, foreign_key: true
      t.references :favorite, null: false, foreign_key: true

      t.timestamps
    end
    add_index :folder_favorites, [:folder_id, :favorite_id], unique: true
  end
end
