class Techniques::YoutubeController < ApplicationController
  before_action :authenticate_user!, except: [ :show ]

  def new
    @technique = Technique.new(source_type: "youtube")
  end

  def create
    @technique = current_user.techniques.build(technique_params)
    @technique.source_type = "youtube"

    if @technique.save
      redirect_to techniques_youtube_path(@technique), success: t("defaults.flash_message.created", item: "Youtubeの#{Technique.model_name.human}")
    else
      flash.now[:error] = t("defaults.flash_message.not_created", item: Technique.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @technique = Technique.find(params[:id])

    # youtubeAPIを引っ張ってくる
    youtube_service = YoutubeService.new
    @movie_title = youtube_service.get_movie_title(@technique.only_id_from_youtube_url)

    # おすすめ動画のためにIDをランダムで引っ張ってくる
    recommend_id = Technique.where(source_type: "youtube").where.not(id: @technique.id).pluck(:id).sample(5)
    @recommend_techniques = Technique.where(id: recommend_id)
  end

  def edit
    @technique = current_user.techniques.find(params[:id])
    @technique.category_names = @technique.categories.pluck(:name).join(",")
  end

  def update
    @technique = current_user.techniques.find(params[:id])

    if @technique.update(technique_params)
      redirect_to techniques_youtube_path(@technique), success: t("defaults.flash_message.updated", item: Technique.model_name.human)
    else
      flash.now[:error] = t("defaults.flash_message.not_updated", item: Technique.model_name.human)
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    technique = current_user.techniques.find(params[:id])
    technique.destroy!
    redirect_to techniques_path, success: t("defaults.flash_message.deleted", item: Technique.model_name.human), status: :see_other
  end

  private

  def technique_params
    params.require(:technique).permit(:title, :source_type, :source_url, :video_timestamp, :category_names)
  end
end
