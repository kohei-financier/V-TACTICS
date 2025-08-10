class RemoveCharacterAndMapFromTechniques < ActiveRecord::Migration[7.2]
  def change
    remove_column :techniques, :character, :string
    remove_column :techniques, :map, :string
  end
end
