class SessionsController < ApplicationController
respond_to :html, :js

  def login
    if request.xhr?
      render :layout => false
    end
  end

  def create_zip
    session[:zip] = params[:zip]
    render :nothing => true, :status => :ok
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

  def destroy
    session.delete(:user_id)
    redirect_to '/'
  end


  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
