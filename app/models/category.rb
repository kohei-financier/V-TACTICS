class Category < ApplicationRecord
  has_many :technique_categories, dependent: :destroy
  has_many :techniques, through: :technique_categories
  has_many :follows, dependent: :destroy
  has_many :followers, through: :follows, source: :user

  validates :name, presence: true
end
