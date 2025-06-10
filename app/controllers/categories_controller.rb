class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    @techniques = @category.techniques.order(created_at: :desc)
  end
end
