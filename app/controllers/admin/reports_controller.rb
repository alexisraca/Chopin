class Admin::ReportsController < ApplicationController
  
  def index
    @orders = Order.all.order(:created_at)
  end

  def show
  end
  
end
