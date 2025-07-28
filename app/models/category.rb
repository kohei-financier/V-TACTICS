class Category < ApplicationRecord
  AGENTS = [
    "アストラ",
    "ブリーチ",
    "ブリムストーン",
    "チェンバー",
    "クローヴ",
    "サイファー",
    "デッドロック",
    "フェイド",
    "ゲッコー",
    "ハーバー",
    "アイソ",
    "ジェット",
    "KAY/O",
    "キルジョイ",
    "ネオン",
    "オーメン",
    "フェニックス",
    "レイズ",
    "レイナ",
    "セージ",
    "スカイ",
    "ソーヴァ",
    "ヴァイパー",
    "ヨル"
  ]

  MAPS = [
    "アビス",
    "アセント",
    "バインド",
    "ブリーズ",
    "フラクチャー",
    "ヘイヴン",
    "アイスボックス",
    "ロータス",
    "パール",
    "スプリット",
    "サンセット"
  ]

  BEGINNER = ["初心者"]

  has_many :technique_categories, dependent: :destroy
  has_many :techniques, through: :technique_categories
  has_many :follows, dependent: :destroy
  has_many :followers, through: :follows, source: :user

  validates :name, presence: true

  scope :agents, -> { where(name: AGENTS) }
  scope :maps, -> { where(name: MAPS) }
  scope :beginner, -> { where(name: BEGINNER) }
  scope :others, -> { where.not(name: AGENTS + MAPS + BEGINNER) }

end
