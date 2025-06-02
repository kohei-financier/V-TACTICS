class Category < ApplicationRecord
  has_many :technique_categories, dependent: :destroy
  has_many :techniques, through: :technique_categories

  validates :name, presence: true
end
