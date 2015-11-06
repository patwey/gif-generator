class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(username: params[:session][:username])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:success] = "Welcome back, #{@user.username}"
      redirect_to @user
    else
      flash.now[:error] = "Invalid Login"
      render :new
    end
  end

  def destroy
    flash[:notice] = "Bye #{current_user.username}"
    session.clear
    redirect_to login_path
  end
end
