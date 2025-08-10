class FoldersController < ApplicationController
  def new
    @folder = Folder.new
  end

  def create
    @folder = current_user.folders.build(folder_params)

    if @folder.save
      redirect_to favorites_technique_path(current_user.id), success: "フォルダの作成に成功しました"
    else
      flash.now[:error] = "フォルダの作成に失敗しました"
      render "techniques/favorites", status: :unprocessable_entity
    end
  end

  def show
    @folder = Folder.find(params[:id])
  end

  private
  def folder_params
    params.require(:folder).permit(:title)
  end
end
