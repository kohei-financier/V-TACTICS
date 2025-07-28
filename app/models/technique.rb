class Technique < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }
  validates :source_type, presence: true
  validates :source_url, presence: true

  belongs_to :user

  enum source_type: { youtube: 1, twitter: 2 }

  has_many :favorites, dependent: :destroy
  has_many :technique_categories, dependent: :destroy
  has_many :categories, through: :technique_categories

  attr_accessor :category_names

  # お気に入り順にソートする
  scope :most_favorites, -> {
    left_joins(:favorites).group(:id).order("count(favorites.id) desc")
  }

  after_save :assign_categories

  after_create_commit :send_notifications_for_followers

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

  private

  def assign_categories
    return if category_names.blank?

    old_categories = categories.to_a

    new_categories = category_names.split(",").map do |name|
      Category.find_or_create_by(name: name.strip)
    end

    self.categories = new_categories
    removed_categories = old_categories - new_categories

    removed_categories.each do |category|
      if category.reload.technique_categories.empty?
        category.destroy
      end
    end
  end

  def send_notifications_for_followers
    if categories.any?
      categories.each do |category|
        category.followers.where.not(id: user_id).each do |follower|
          notification = Notification.create!(
            user: follower,
            notifiable: self,
            message: "#{category.name}に新しいテクニック「#{title}」が投稿されました。"
          )
          NotificationMailer.new_technique_notification(follower, self, category).deliver_later
        end
      end
    else
      Rails.logger.warn "Warning: Technique ##{id} has no categories associated after commit. No notifications will be sent."
    end
  end
end
