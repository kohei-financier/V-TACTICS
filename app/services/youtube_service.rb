require 'google/apis/youtube_v3'

class YoutubeService
  def initialize
    @youtube = Google::Apis::YoutubeV3::YouTubeService.new
    @youtube.key = Rails.application.credentials.dig(:google, :youtube_api_key)
  end

  def get_movie_title(video_id)
    Rails.cache.fetch("youtube_service/movie_title/#{video_id}", expires_in: 1.day) do
    response = @youtube.list_videos("snippet", id: video_id)
    response.items[0].snippet.title
    end
  end
end
