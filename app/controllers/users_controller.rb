class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def get_polling_info
    user = User.find_by(id: session[:user_id])
    @polling_place = Zipcode.get_polling_place(("#{user.street_address} #{user.city} #{user.state}").gsub(' ', "%20"))['address']


    render partial: 'users/get_polling_info', layout: false
  end

  def create
    @user = User.new(user_params)
    @user.token = (0...20).map { (1..100).to_a[rand(26)] }.join
    if @user.save
      IvotedMailer.welcome(@user).deliver
      session[:user_id] = @user.id
      session[:zip] = @user.zip
      redirect_to "/users/#{@user.id}"
    else
      @errors = @user.errors.full_messages
      @user.destroy
      render "new"
    end
  end


  def unsubscribe
    user = User.find_by(id: params[:id])
    if user.token == params[:token]
      puts "token is the same as params[token]"
      user.subscribe = false
      user.token = (0...20).map { (1..100).to_a[rand(26)] }.join
      user.save
      redirect_to "/"
    end
  end

  def check_for_errors
    @errors = []
    @errors = ['Please make a user or login first'] if session[:user_id].nil?
    @errors = ['Please select a valid address'] if session[:zip].blank?
    return @errors
  end

  def show
    if check_for_errors.length > 0
      @user = User.new
      render 'new'
      return
    end

    @user_friendly_display = {true: "Yes", false: "No", nil: "No"}
    @zip  = session[:zip]

    all_candidates = Candidate.query_for_candidates(@zip)
    @candidates = Candidate.remove_appointed_politicians_and_current_president(all_candidates)

    @user = User.find_by(id: session[:user_id])
    @zipcode = Zipcode.make_zipcode_object(@zip)

  end

  def edit
    if session[:user_id].present?
      @user = current_user
    else
      render :'../../public/407'
    end
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
