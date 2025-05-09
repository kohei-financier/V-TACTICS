class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  validates :name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, uniqueness: true
  validates :encrypted_password, presence: true
  validates :uid, presence: true, uniqueness: { scope: :provider }, if: -> { uid.present? }

  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable,
  :omniauthable, omniauth_providers: %i[google_oauth2]

  has_many :techniques, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_techniques, through: :favorites, source: :technique
  has_many :folders, dependent: :destroy

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

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.name = auth.info.name
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end
end
