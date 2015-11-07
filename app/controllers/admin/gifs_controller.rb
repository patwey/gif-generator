class Admin::GifsController < Admin::BaseController

  def index
    @categories = Category.all
  end

  def new
  end

  def create
    gif = Admin::GifGenerator.generate(params[:search][:name])
    if gif.save
      flash[:success] = "Gif added to your database"
      redirect_to admin_gifs_path
    else
      flash[:notice] = "No gif available with that name"
      render :new
    end
  end

  def destroy
    gif = Gif.find(params[:gif_to_delete][:gif_id])
    category = gif.category
    Gif.delete(gif.id)
    Category.delete(category.id) if category.gifs.empty?
    redirect_to admin_gifs_path
  end

end
