class FavoritesController < ApplicationController
  def create
    technique = Technique.find(params[:technique_id])
    current_user.favorite(technique)
    # redirect_to techniques_path, success: "お気に入りに追加しました：マイページで確認できます"
  end

  def destroy
    technique = current_user.favorites.find(params[:id]).technique
    current_user.unfavorite(technique)
    # redirect_to techniques_path, success: "お気に入りを解除しました", status: :see_other
  end
end
