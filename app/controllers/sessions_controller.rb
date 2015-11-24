class SessionsController < ApplicationController
respond_to :html, :js

  def new
    if request.xhr?
      render :layout => false
    end
  end

  def create
    user = User.find_by(email: user_params[:email])
    if user && user.authenticate(user_params[:password])
      session[:user_id] = user.id
      set_sessions
      redirect_to '/'

    else
      flash[:login_error] = "Invalid credentials. Please try again."

      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to '/'
  end


  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
