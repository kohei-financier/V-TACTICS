class TechniquesController < ApplicationController
  def index
    # まとめて記載
    most_favorites_techniques = Technique.most_favorites.includes(:categories)

    if params[:most_favorites]
      @techniques = most_favorites_techniques
    else
      @techniques = Technique.includes(:categories).order(created_at: :desc)
    end

    @swiper_youtube_techniques = most_favorites_techniques.where(source_type: "youtube").limit(5)

    @youtube_techniques = @techniques.where(source_type: "youtube").limit(6)
    @twitter_techniques = @techniques.where(source_type: "twitter").limit(6)

    @beginner_categories  = Category.beginner
    @agents_categories = Category.agents
    @maps_categories = Category.maps
    @others_categories = Category.others
  end

  def search
    @q = Technique.ransack(params[:q])
    @results = @q.result(distinct: true).includes(:categories)
  end

  def favorites
    @favorite_techniques = current_user.favorite_techniques.includes(:categories)
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
