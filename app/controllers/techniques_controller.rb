class TechniquesController < ApplicationController
  def index
    @techniques = Technique.includes(:user)
  end

  def new
    @technique = Technique.new
  end

  def create
    @technique = current_user.techniques.build(technique_params)
    if @technique.save
      redirect_to techniques_path, notice: t('defaults.flash_message.created', item: Technique.model_name.human)
    else
      flash.now[:error] = t('defaults.flash_message.not_created', item: Technique.model_name.human)
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @technique = Technique.find(params[:id])
  end

  private

  def technique_params
    params.require(:technique).permit(:title, :source_type, :source_url, :video_timestamp, :character, :map)
  end
end
