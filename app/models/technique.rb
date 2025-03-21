class Technique < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }
  validates :source_type, presence: true
  validates :source_url, presence: true

  belongs_to :user
  enum source_type: { youtube: 1, twitter: 2 }

  def embed_id_from_youtube_url
    # 埋め込み形式でIDを抜き出し（プレイヤー用）
    source_url.split('/').last if youtube?
  end

  def only_id_from_youtube_url
    # IDだけを抜き出し（サムネイル用）
    embed_id_from_youtube_url.split('?').first
  end

  def calculate_video_timestamp
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
