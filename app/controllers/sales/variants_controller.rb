class Sales::VariantsController < ApplicationController
  before_action :load_statement

  private

  def load_statement
    @statement = Statement.find(params[:statement_id])
  end
end
