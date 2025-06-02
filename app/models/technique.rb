class Technique < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }
  validates :source_type, presence: true
  validates :source_url, presence: true

  belongs_to :user
  enum source_type: { youtube: 1, twitter: 2 }
  has_many :favorites, dependent: :destroy

  has_many :technique_categories, dependent: :destroy
  has_many :categories, through: :technique_categories

  def embed_id_from_youtube_url
    # 埋め込み形式でIDを抜き出し（プレイヤー用）
    source_url.split("/").last if youtube?
  end

  def only_id_from_youtube_url
    # IDだけを抜き出し（サムネイル用）
    embed_id_from_youtube_url.split("?").first
  end

  def x_to_twitter_change_url
    return unless twitter? && source_url.match?(/\Ahttps:\/\/x\.com\//)
    source_url.sub("x.com", "twitter.com")
  end

  def calculate_video_timestamp
    if source_type == "youtube"
      time = video_timestamp.split(":").map(&:to_i)

      case time.length
      when 3
        time[0]*3600 + time[1]*60 + time[2]
      when 2
        time[0]*60 + time[1]
      when 1
        time[0]
      else
        0
      end
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "title" ]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
