class TechniquesController < ApplicationController
  def index
    @techniques = Technique.includes(:user)
    @swiper_techniques = Technique.includes(:user).limit(5)
  end

  def search
    @q = Technique.ransack(params[:q])
    @results = @q.result(distinct: true).includes(:user)
  end
end
