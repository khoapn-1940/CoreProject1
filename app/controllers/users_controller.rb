class UsersController < ApplicationController
  before_action :load_user, only: [:edit, :update]
  def new
    @user = User.new
  end

  def edit; end

  def update
    if @user.update_attributes(update_params)
      flash[:success] =
        t("authentication.controllers.users_controller.flash.update_success")
      redirect_to root_path
    else
      flash[:success] =
        t("authentication.controllers.users_controller.flash.update_fail")
      render :edit
    end
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] =
        t("authentication.controllers.users_controller.flash.register_success")
      redirect_to signup_path
    else
      flash[:danger] =
        t("authentication.controllers.users_controller.flash.register_fail")
      render :new
    end
  end


  private

  def user_params
    params.require(:user).permit :name, :email, :phone, :bank_account,
      :password, :password_confirmation
  end

  def update_params
    params.require(:user).permit :name, :email, :phone, :bank_account, :role
  end

  def load_user
    if params.key? :id
      @user = User.find_by_id params[:id]
    else
      @user = current_user
      return if @user
      flash[:warning] =
        t("authentication.controllers.users_controller.flash.no_user")
      redirect_to root_path
    end
  end
end
