class Sales::OrdersController < ApplicationController
  def new
    @order = find_or_create_order
    redirect_to edit_sales_statement_path(@order.statements.last)
  end
  def find_or_create_order
    order = Order.includes(statements: :line_items).
                  where(line_items: { statement_id: nil  }).
                  where("orders.user_id = ?", current_user.id).
                  order("orders.created_at DESC").first

    order.statements.create(total: 0.0) if order.statements.empty?
    if !order 
      order = Order.create(user: current_user, state: Order::SUMARY)
      order.statements.create(total: 0.0) 
    end
    order
  end
end
