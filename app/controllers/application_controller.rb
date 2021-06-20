class ApplicationController < ActionController::API

  before_action :authenticate 

  def authenticate
    
    auth_header = request.headers[:Authorization]

    if !auth_header
      render json: {error: 'Auth bearer token header must be present'}, stauts: :forbidden
    else
      token = auth_header.split(' ')[1]
      secret = 'uiasdfyasdjfkliudsyfxcvkljedyaffrhSHDIASUdhekjnlkujhdfASLD'
      begin
        decoded_token = JWT.decode token, secret
        payload = decoded_token.first
        @user = User.find payload['user_id']
      rescue => exception
        render json: { error: 'Bad token'}, status: :forbidden
      end
    end
  end

end
