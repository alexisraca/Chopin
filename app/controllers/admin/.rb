class Admin::RetiredUsersController < ApplicationController

  def index
    @users = User.all.order(:created_at)
  end
  
end
