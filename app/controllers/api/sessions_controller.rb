class Api::SessionsController < ActionController::API
  def create
    user = User.find_by(email: params[:email])
    if user&.valid_password?(params[:password])
      token = JsonWebToken.encode(user_id: user.id)
      render json: { user: user, token: token }, status: :ok
    else
      render json: { errors: [ "Invalid email or password" ] }, status: :unauthorized
    end
  end
end
