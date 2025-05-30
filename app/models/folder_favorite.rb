class FolderFavorite < ApplicationRecord
  belongs_to :folder
  belongs_to :favorite

  validates :folder_id, uniqueness: { scope: :favorite_id }
end