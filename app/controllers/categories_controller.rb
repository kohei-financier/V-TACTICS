class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    @techniques = @category.techniques.includes(:categories)

    if params[:most_favorites] == "true"
      @techniques = @techniques.most_favorites
    else
      @techniques = @techniques.order(created_at: :desc)
    end
    @youtube_categories_techniques = @techniques.where(source_type: "youtube")
    @twitter_categories_techniques = @techniques.where(source_type: "twitter")
  end
end
