class SessionsController < ApplicationController


  def login
  end


  def create
    user = User.find_by(email: user_params[:email])
    if user && user.authenticate(user_params[:password])
      session[:user_id] = user.id
      redirect_to '/'
    else
      render :login
    end
  end


  def user_params
    params.require(:user).permit(:email, :password)
  end
end
