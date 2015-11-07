class FavoritesController < ApplicationController
  def create
    user = User.find(params[:user_id])
    user.gifs << Gif.find(params[:favorite][:gif_id])
    redirect_to gifs_path
  end
end
