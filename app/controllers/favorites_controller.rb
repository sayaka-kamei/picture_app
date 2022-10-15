class FavoritesController < ApplicationController

  def index
    @favorites = current_user.favorites
  end  

  def create
    favorite = current_user.favorites.create(picture_id: params[:picture_id])
    redirect_to favorites_path, notice: "#{favorite.picture.user.name}さんのPictureをお気に入り登録しました"
  end
  
  def destroy
    favorite = current_user.favorites.find_by(id: params[:id]).destroy
    redirect_to pictures_path, notice: "#{favorite.picture.user.name}さんのPictureをお気に入り解除しました"
  end
  
end
