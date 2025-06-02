class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :technique

  validates :user_id, uniqueness: { scope: :technique_id }
end
