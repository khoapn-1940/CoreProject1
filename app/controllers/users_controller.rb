class UsersController < ApplicationController
  before_action :load_user, only: [:edit, :update]
  def new
    @user = User.new
  end

  def edit; end

  def update
    if @user.update_attributes(user_params)
      flash[:success] =
        t("authentication.controllers.users_controller.flash.update_success")
      redirect_to view_my_information_path
    else
      flash[:danger] =
        t("authentication.controllers.users_controller.flash.update_fail")
      render :edit
    end
  end

  def create
    @user = User.new user_params
    if @user.save
      flash["info"] =
        t("authentication.controllers.users_controller.flash.register_success")
      redirect_to signup_path
    else
      flash["info"] =
        t("authentication.controllers.users_controller.flash.register_fail")
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :phone, :bank_account,
      :password, :password_confirmation, :avatar
  end

  def load_user
    @user = current_user
    return if @user
    flash[:warning] =
      t("authentication.controllers.users_controller.flash.no_user")
    redirect_to root_path
  end
end
