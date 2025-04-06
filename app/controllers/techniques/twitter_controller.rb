class Techniques::TwitterController < ApplicationController
  before_action :authenticate_user!, except: [ :show ]
  def new
    @technique = Technique.new(source_type: "twitter")
  end

  def create
    @technique = current_user.techniques.build(technique_params)
    @technique.source_type = "twitter"

    if @technique.save
      redirect_to techniques_twitter_path(@technique), success: t("defaults.flash_message.created", item: "Xの#{Technique.model_name.human}")
    else
      flash.now[:error] = t("defaults.flash_message.not_created", item: Technique.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @technique = Technique.find(params[:id])
    recommend_id = Technique.where(source_type: "twitter").where.not(id: @technique.id).pluck(:id).sample(2)
    @recommend_techniques = Technique.where(id: recommend_id)
  end

  def edit
    @technique = current_user.techniques.find(params[:id])
  end

  def update
    @technique = current_user.techniques.find(params[:id])
    if @technique.update(technique_params)
      redirect_to techniques_twitter_path(@technique), success: t("defaults.flash_message.updated", item: Technique.model_name.human)
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
    params.require(:technique).permit(:title, :source_type, :source_url, :video_timestamp, :character, :map)
  end
end
