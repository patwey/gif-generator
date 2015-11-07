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

end
