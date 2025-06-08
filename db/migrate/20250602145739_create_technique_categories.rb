class CreateTechniqueCategories < ActiveRecord::Migration[7.2]
  def change
    create_table :technique_categories do |t|
      t.references :technique, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
