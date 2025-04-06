class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  validates :name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, uniqueness: true
  validates :encrypted_password, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :techniques, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_techniques, through: :favorites, source: :technique

  def own?(technique)
    self.id == technique.user_id
  end

  def favorite(technique)
    favorite_techniques << technique
  end

  def unfavorite(technique)
    favorite_techniques.destroy(technique)
  end

  def favorite?(technique)
    favorite_techniques.include?(technique)
  end
end
