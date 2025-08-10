class FavoritesController < ApplicationController
  def create
    @technique = Technique.find(params[:technique_id])
    current_user.favorite(@technique)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to techniques_path, success: "お気に入りに追加しました：マイページで確認できます" }
    end
  end

  def destroy
    favorite = current_user.favorites.find(params[:id])
    @technique = favorite.technique
    current_user.unfavorite(@technique)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to techniques_path, success: "お気に入りを解除しました", status: :see_other }
    end
  end
end
