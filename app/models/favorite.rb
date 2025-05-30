class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :technique

  has_many :folder_favorites, dependent: :destroy
  has_many :folders, through: :folder_favorites

  validates :user_id, uniqueness: { scope: :technique_id }
end
