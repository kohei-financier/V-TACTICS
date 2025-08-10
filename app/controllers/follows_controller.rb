class FollowsController < ApplicationController
  before_action :authenticate_user!

  def create
    @category = Category.find(params[:id])
    unless current_user.following_categories.include?(@category)
      current_user.following_categories << @category
      redirect_to @category, notice: "#{@category.name}をフォローしました。"
    else
      redirect_to @category, alert: "既に#{@category.name}をフォローしています。"
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "指定されたカテゴリーが見つかりませんでした。"
  end

  def destroy
    @category = Category.find(params[:id])
    if current_user.following_categories.include?(@category)
      current_user.following_categories.delete(@category)
      redirect_to @category, notice: "#{@category.name}のフォローを解除しました。"
    else
      redirect_to @category, alert: "このカテゴリーはフォローしていません。"
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "指定されたカテゴリーが見つかりませんでした。"
  end
end
