class Admin::UsersController < ApplicationController
  def new
    @user = User.new
  end

  def index
   @q = User.ransack(params[:q])
   @users = @q.result(distinct: true).order(:created_at)
  end

  def edit
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy unless @user == current_user
    redirect_to admin_users_path
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Creacion Existosa"
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update(password_or_not_params)
  end
  

  private

  def password_or_not_params
    if params[:user][:password].blank?
      user_no_password_params
    else
      user_params
    end
  end

  def user_no_password_params
    params.require(:user).
      permit(:username, :email, :first_name, :last_name)
  end

  def user_params
    params.require(:user).
      permit(:username, :password, :password_confirmation, :email, :first_name, :last_name)
  end
end

