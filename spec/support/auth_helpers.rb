module AuthHelpers
  def auth_with_user(user)
    request.headers['API-AUTH-TOKEN'] = user.auth_token.to_s
  end

  def clear_auth_token
    request.headers['API-AUTH-TOKEN'] = nil
  end
end
