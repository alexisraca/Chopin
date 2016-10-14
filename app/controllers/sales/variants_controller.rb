class Sales::VariantsController < ApplicationController
  before_action :load_statement

  def index
    @q = Variant.ransack(params[:q])
    @variants = @q.result(distinct: true).
                  paginate(page: params[:page], per_page: 8).
                  order(:created_at)
  end

  private

  def load_statement
    @statement = Statement.find(params[:statement_id])
  end
end
