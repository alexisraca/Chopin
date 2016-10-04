class Admin::BranchesController < ApplicationController
  def index
    @q = Branch.ransack(params[:q])
    @branches = @q.result(distinct: true).order(:created_at)
  end

  def new
    @branch = Branch.new
  end

  def create
    @branch = Branch.new(branch_params)
    if @branch.save
      flash[:notice] = "Sucursal guardada"
    end
  end

  def edit
    @branch = Branch.find(params[:id])
  end

  def update
    @branch = Branch.find(params[:id])
    if @branch.update(branch_params)
      flash[:notice] = "Sucursal actualizada"
    end
  end

  private

  def branch_params
    params.require(:branch).permit(:name, :description, :manager_id)
  end
end
