class Admin::OrdersController < ApplicationController
  def index
    @q = Order.ransack(params[:q])
    @orders = @q.result(distinct: true).order(:created_at)
  end

  def new
    @order = Order.create(user: current_user, state: "summary")
    redirect_to edit_admin_order_path(@order)
  end
  
  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    redirect_to admin_orders_path
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      flash[:notice] = "Orden guardada"
    end
  end

  def edit
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    if @order.update_attributes(order_params)
      redirect_to admin_orders_path
    else
      render :edit
    end
  end

  def order_params
    params.require(:order).
      permit(:user_id, :comment, :completed_at, :total, :state)
  end

end
