class CreateFavorites < ActiveRecord::Migration[7.2]
  def change
    create_table :favorites do |t|
      t.references :user, foreign_key: true
      t.references :technique, foreign_key: true

      t.timestamps
    end
    add_index :favorites, [ :user_id, :technique_id ], unique: true
  end
end
