class TechniquesController < ApplicationController
  def index
    @techniques = Technique.includes(:user)
  end
end
