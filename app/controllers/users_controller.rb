class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      ReminderEmail.create(user_id: @user.id, subject: "welcome")
      IvotedMailer.welcome(@user).deliver
      session[:user_id] = @user.id
      session[:zip] = @user.zip
      redirect_to "/users/#{@user.id}"
    else
      @errors = @user.errors.full_messages
      render "new"
    end
  end

  def show
    @user_friendly_display = {true: "Yes", false: "No", nil: "No"}
    @index = 1
    @user = User.find_by(id: params[:id])
    @zip = @user.zip
    if !Zipcode.find_by(zip: @zip)
      @errors = ['Please enter a valid zipcode']
      render "new"
    else
      Candidate.remove_appointed_politicians(@zip)
      @candidates = Candidate.where(zip: @zip).where.not("name LIKE ?", "%#{Candidate.current_president}%")
      @offices = []
      @candidates.each do |candidate|
        @offices << candidate.office
      end
      @offices.uniq!
      @district = Zipcode.get_district(("#{@user.street_address} #{@user.city}, #{@user.state}").gsub(' ', "%20")).gsub('s\'s', 's\'')

      @district = Zipcode.get_district(("#{@user.street_address} #{@user.city}, #{@user.state} #{@zip}").gsub(' ', "%20")).gsub('s\'s', 's\'')
      @state_elections = StateElectionInfo.where("election_title LIKE ?", "%#{Zipcode.find_by(zip: @zip).state_name}%")
      polling_place = Zipcode.get_polling_place(("#{@user.street_address} #{@user.city}, #{@user.state}").gsub(' ', "%20"))['address']
      if polling_place['locationName']
        @polling_place = polling_place['locationName'] + ', ' + polling_place['line1'] + '. ' +  polling_place['city'] + ', ' + polling_place['state'] + " " + polling_place['zip']
      else
        @polling_place = polling_place
      end
      @voter_registration_data = StateVotingInformation.find_by(name: Zipcode.find_by(zip: @zip).state_name)
    end
    @zipforwebsite = Zipcode.find_by(zip: @zip)
    @statewebsite = StateWebsite.find_by(name: @zipforwebsite.state_name)
  end

  def edit
    @user = current_user
  end

  def update
    @user = User.find(current_user.id)
    @user.update(user_params)
    if @user.valid?
      flash[:user_updated] = "Your profile was successfully updated"
      redirect_to '/'
    else
      @errors = @user.errors.full_messages
      render 'edit'
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :street_address, :city, :state, :zip, :password, :subscribe)
  end
end
