class Api::RegistrationsController < ActionController::API
  def create
    user = User.new(signup_params)
    if user.save
      render json: { message: "User has already been created successfully" }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def signup_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
