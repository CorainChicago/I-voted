class UsersController < ApplicationController

  def new
    @user = User.new
  end


  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      redirect_to "/"
    else
      @errors = @user.errors.full_messages
      render "new"
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :street_address, :city, :state, :zip, :password)
  end
end
