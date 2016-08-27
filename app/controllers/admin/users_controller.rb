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
end

