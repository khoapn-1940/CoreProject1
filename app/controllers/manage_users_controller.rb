class ManageUsersController < ApplicationController
  def new
    return unless User.roles[session[:role]] == User.roles[:admin]
    @user_all = User.all
  end

  def destroy
    @user = User.find_by_id params[:id]
    if @user.destroy
      flash[:success] = "Deleted !"
      redirect_to manage_users_path
    else
      flash[:danger] = "Delete Fail !"
      redirect_to manage_users_path
    end
  end
end
