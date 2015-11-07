class FavoritesController < ApplicationController
  def create
    user = User.find(params[:user_id])
    user.gifs << Gif.find(params[:favorite][:gif_id])
    redirect_to gifs_path
  end

  def destroy
    user = User.find(params[:user_id])
    user.gifs.delete(params[:unfavorite][:gif_id])
    redirect_to user_path user
  end
end
