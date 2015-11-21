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
    @zip = session[:zip]
    @user = User.find_by(id: params[:id])
    if !Zipcode.find_by(zip: @zip)
      @errors = ['Please enter a valid zipcode']
      render "new"
    else
      @candidates = Candidate.where(zip: @zip).where("name != ?", "Barack Obama II")
      @district = Zipcode.get_district(("#{@user.street_address} #{@user.city}, #{@user.state} #{@zip}").gsub(' ', "%20")).gsub('s\'s', 's\'')

      @state_elections = StateElectionInfo.where("election_title LIKE ?", "%#{Zipcode.find_by(zip: @zip).state_name}%")
      polling_place = Zipcode.get_polling_place(("#{@user.street_address} #{@user.city}, #{@user.state} #{@zip}").gsub(' ', "%20"))['address']
      if polling_place['locationName']
        @polling_place = polling_place['locationName'] + ', ' + polling_place['line1'] + '. ' +  polling_place['city'] + ', ' + polling_place['state'] + " " + polling_place['zip']
      else
        @polling_place = polling_place
      end
      @voter_registration_data = StateVotingInformation.find_by(name: Zipcode.find_by(zip: @zip).state_name)
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :street_address, :city, :state, :zip, :password)
  end
end
