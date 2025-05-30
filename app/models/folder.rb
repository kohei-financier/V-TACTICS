class Folder < ApplicationRecord
  belongs_to :user

  has_many :folder_favorites, dependent: :destroy
  has_many :favorites, through: :folder_favorites

  validates :title, presence: true, length: { maximum: 30 }
  validates :user_id, presence: true
end
