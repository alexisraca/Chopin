class DashboardController < ApplicationController

  def index
    @q = User.non_master.ransack(params[:q])
    @users = @q.result(distinct: true).
               paginate(page: params[:page], per_page: 30).
               order(:created_at)
  end

  def show
  end

end
