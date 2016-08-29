class Admin::UsersController < ApplicationController
  def new
    @user = User.new
  end

  def index
    @users = User.all.order(:created_at)
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
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(password_or_not_params)
      flash[:notice] = "Actualización Existosa"
      redirect_to admin_users_path
    else
      render :edit
    end
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
      permit(:username, :email)
  end

  def user_params
    params.require(:user).
      permit(:username, :password, :password_confirmation, :email)
  end
end

