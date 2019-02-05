class ApplicationController < ActionController::API

  def encode_token(payload) #{ user_id: 2 }
    JWT.encode(payload, ENV["JWT_SECRET"]) #issue a token, store payload in token
  end

  # def auth_header
  #   request.headers['Authorization'] # Bearer <token>
  # end

  def current_user
    token = request.headers['Authorization']
    revealed_token = decoded_token(token)
    id = revealed_token['id']
    User.find_by(id: id)
  end

  def decoded_token(token)
      begin
      JWT.decode(token, ENV["JWT_SECRET"]).first
      rescue JWT::DecodeError
        {}
      end
  end

  # def logged_in?
  #   !!current_user
  # end

  # def authorized
  #   render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
  # end
end
