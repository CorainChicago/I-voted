class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      redirect_to "/users/#{@user.id}"
    else
      @errors = @user.errors.full_messages
      render "new"
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    @zip = session[:zip]
    @candidates = Candidate.where(zip: @zip).where("name != ?", "Barack Obama II")
    polling_place = Zipcode.get_polling_place(("#{@user.street_address} #{@user.city}, #{@user.state} #{@zip}").gsub(' ', "%20"))['address']
    @polling_place = polling_place['locationName'] + ', ' + polling_place['line1'] + '. ' +  polling_place['city'] + ', ' + polling_place['state'] + " " + polling_place['zip']
  end

  private
  def user_params
    params.require(:user).permit(:email, :street_address, :city, :state, :zip, :password)
  end
end
