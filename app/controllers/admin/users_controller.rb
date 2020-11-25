class Admin::UsersController < Admin::BaseController
  def index
    @users = User.all
  end
  def show
    # @user = User.find(params[:user_id])
    @user = User.find(params[:id])
  end
end
