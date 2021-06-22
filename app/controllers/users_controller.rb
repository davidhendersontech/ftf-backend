class UsersController < ApplicationController

  skip_before_action :authenticate, only: [:create, :login]

  def index
    @users = User.all
    render json: @users, status: :ok
  end

  def create
    #TODO : check if username is valid
    @user = User.create user_params
    render json: @user, status: :created
  end

  def createtoken
    puts "body under here =============="
    puts params
    @band_name =  params[:band_name]
    @followers = params[:followers]
    @token = @user.tokens.create band_name: @band_name, followers: @followers
    render json: @token, status: :created
  end

  def login
    @user = User.find_by username: params[:user][:username]
    
    if !@user
      render json: { error: 'Invalid username or password'}, status: :unauthorized
    else

      if !@user.authenticate params[:user][:password]
        render json: { error: 'Invalid username or password'}, status: :unauthorized
      else
        # user authenticated 
        payload = { user_id: @user.id}
        secret = 'uiasdfyasdjfkliudsyfxcvkljedyaffrhSHDIASUdhekjnlkujhdfASLD'
        @token = JWT.encode payload, secret
        render json: {token: @token}, status: :ok
      end

    end
  end

  def profile
    render json: @user, include: :tokens, status: :ok
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

end
