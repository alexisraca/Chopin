class Admin::UsersController < ApplicationController
  def new
    @user = User.new
  end

  def index
    @users = User.all
  end
  def edit
    @user = User.find(params[:id])  	
  end
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path
  end
end

