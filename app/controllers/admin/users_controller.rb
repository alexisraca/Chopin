class Admin::UsersController < ApplicationController
  def new
    @user = User.new
  end

  def index
   @q = default_user_scope.non_master.ransack(params[:q])
   @users = @q.result(distinct: true).
              paginate(page: params[:page], per_page: 30).
              order(:created_at)
  end

  def edit
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    if @user == current_user
      flash[:warning] = "No puede desactivar su propio usuario"
    else
      @user.destroy
      flash[:notice] = "Usuario desactivado"
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Usuario guardado"
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update(password_or_not_params)
    flash[:notice] = "Usuario actualizado"
  end

  def restore
    @user = User.find(params[:user_id])
    @user.restore
    flash[:notice] = "Usuario restaurado"
  end

  private

  def default_user_scope
    if params[:q].blank?
      User.where(deleted_at: nil)
    else
      User
    end
  end

  def password_or_not_params
    if params[:user][:password].blank?
      user_no_password_params
    else
      user_params
    end
  end

  def user_no_password_params
    params.require(:user).
      permit(:username, :email, :first_name, :last_name, :role_id)
  end

  def user_params
    params.require(:user).
      permit(:username, :password, :password_confirmation, :email, :first_name, :last_name, :role_id, :phone, :address)
  end
end

