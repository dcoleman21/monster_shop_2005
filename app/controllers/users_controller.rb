class UsersController < ApplicationController

  def new
  end

  def create
    @user = User.new(user_params)
    if @user.save && params[:password] == params[:confirm_password]
      session[:user_id] = @user.id
      flash[:success] = "You are now registered and logged in"
      redirect_to '/profile'
    else
      flash.now[:alert] = @user.errors.full_messages.first
      render :new
    end
  end

  def show
  end

  private
    def user_params
      params.permit(:name, :address, :city, :state, :zip, :email, :password)
    end
end
