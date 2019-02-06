class Api::V1::UsersController < ApplicationController

  def index
    @users = User.all
    render json: User.includes(:events),
    include: ['events']
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      @token = encode_token(id: @user.id)
      render json: { username: @user.username, token: @token }, status: :created
    else
      render json: { error: 'failed to create user' }, status: :not_acceptable
    end
  end

    def show
        @user = User.find(params[:id])
        render json: {
        user_details: @user,
        joined_events: @user.events,
        hosted_events: Event.where(user_id: @user.id)
      }

    end

    def update
        @user.update(user_params)
        if @user.save
         render json: @user, status: :accepted
        else
         render json: { errors: @user.errors.full_messages }, status: :unprocessible_entity
        end
    end

  def profile
    render json: { user: UserSerializer.new(current_user) }, status: :accepted
  end

    def validate
      @user = current_user
      if @user
        render json: {username: @user.username, token: encode_token({id: @user.id})}
      else
        render json: {error: "User not found."}, status: 404
      end
    end

    def signin
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      render json: {username: @user.username, token: encode_token({id: @user.id})}
    else
      render json: {error: "Username/password combination invalid."}, status: 404
    end
  end

  def get_events
    @user = current_user

    if @user 
        render json: @user.events
     else
       render json: {error: "User not found."}, status: 404
      end
  end


  private

  def user_params
    params.permit(:username, :password)
  end
end
