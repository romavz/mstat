class ApplicationController < ActionController::API
  before_action :authenticate

  def logged_in?
    current_user.present?
  end

  def current_user
    @current_user ||=
      if auth_token.present?
        User.find(auth['user'])
      end
  end

  def authenticate
    render json: { error: 'unauthorized' }, status: :unauthorized unless logged_in?
  end

  private

  def auth_token
    request.env['API-AUTH-TOKEN']
  end

  def auth
    Auth.decode(auth_token)
  end
end
