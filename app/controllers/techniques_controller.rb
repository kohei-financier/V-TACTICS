class TechniquesController < ApplicationController
  def index
    @techniques = Technique.includes(:user)
  end

  def search
    @q = Technique.ransack(params[:q])
    @results = @q.result(distinct: true).includes(:user)
  end
end
