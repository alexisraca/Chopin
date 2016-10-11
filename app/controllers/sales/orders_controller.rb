class Sales::OrdersController < ApplicationController
  def new
    @q = Variant.ransack(params[:q])
    @variants = @q.result(distinct: true).
                   paginate(page: params[:page], per_page: 10).
                   order(:created_at)
    @order = find_or_create_order
  end
  def find_or_create_order
    order = Order.includes(statements: :line_items).
                  where(line_items: { statement_id: nil  }).
                  order("orders.created_at DESC").first
    if !order 
      order = Order.create(user: current_user, state: Order::SUMARY)
      order.statements.create(total: 0.0) 
    end
    order
  end
end
