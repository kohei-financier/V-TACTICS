class CreateTechniques < ActiveRecord::Migration[7.2]
  def change
    create_table :techniques do |t|
      t.string :title, null: false
      t.integer :source_type, null: false
      t.string :source_url, null: false
      t.integer :video_timestamp
      t.string :character
      t.string :map
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
