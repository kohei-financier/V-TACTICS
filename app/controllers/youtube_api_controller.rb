class YoutubeApiController < ApplicationController

  def title
    video_id = params[:video_id]

    if video_id.blank?
      return render json: { error: 'ビデオIDが必要です' }, status: :bad_request
    end

    begin
      youtube_service = YoutubeService.new
      movie_title = youtube_service.get_movie_title(video_id)
      render json: { title: movie_title }
    rescue => e
      Rails.logger.error "YouTubeAPIのエラー： #{ e.message }"
      render json: { error: 'ビデオタイトルの取得に失敗しました' }, status: :internal_server_error
    end
  end
end