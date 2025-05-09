class Folder < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: { maximum: 30 }
end
