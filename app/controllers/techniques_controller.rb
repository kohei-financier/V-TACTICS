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
      redirect_to techniques_path
    else
      render :new
    end
  end

  private

  def technique_params
    params.require(:technique).permit(:title, :source_type, :source_url, :video_timestamp, :character, :map)
  end
end
