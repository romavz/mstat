class SessionsController < ApplicationController
  skip_before_action :authenticate

  def create
    user = User.find_by(email: auth_params[:email])

    if user&.authenticate?(auth_params[:password])
      render json: { api_auth_token: user.auth_token }
    else
      render json: { errors: "Not authenticated" }, status: :unauthorized
    end
  end

  private

  def auth_params
    params.require(:auth).permit(:email, :password)
  end
end
