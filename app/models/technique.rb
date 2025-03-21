class Technique < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }
  validates :source_type, presence: true
  validates :source_url, presence: true

  belongs_to :user
end
