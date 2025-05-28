require 'google/apis/youtube_v3'

class YouTubeService
  def initialize
    youtube = Google::Apis::YoutubeV3::YouTubeService.new
    youtube.key = Rails.application.credentials.dig(:google, :youtube_api_key)
  end

  def get_movie_title(video_id)
    youtube.list_videos("snippet", id: video_id)
  end
end


# options = {
#   :channelId => 'UCPyNsNSTUtywkekbDdCA_8Q', #YouTubeチャンネルのIDを指定
#   :order => "date"                          #日付順で動画を取得
# }

# response = youtube.list_searches(:snippet, options)

# @video_title = response[:items][0][:snippet][:title]

