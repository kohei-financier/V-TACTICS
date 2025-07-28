class TechniquesController < ApplicationController
  def index
    if params[:most_favorites]
      @techniques = Technique.most_favorites
    else
      @techniques = Technique.includes(:user).order(created_at: :desc)
    end

    @swiper_techniques = Technique.includes(:user).order(created_at: :desc).limit(5)
    @youtube_techniques = @techniques.where(source_type: "youtube").limit(6)
    @twitter_techniques = @techniques.where(source_type: "twitter").limit(6)
    @categories = Category.all
  end

  def search
    @q = Technique.ransack(params[:q])
    @results = @q.result(distinct: true).includes(:user)
  end

  def favorites
    @favorite_techniques = current_user.favorite_techniques.includes(:user)
    @folders = current_user.folders.includes(:user)

    @folder = Folder.new
    @my_folders = current_user.folders.includes(:user)

    @followed_categories = current_user.following_categories.all
  end

  def autocomplete
    @techniques = Technique.where("title LIKE ?", "%#{params[:q]}%")

    respond_to do |format|
      format.html { render layout: false }
    end
  end

  private
  def folder_params
    params.require(:folder).permit(:title)
  end
end
