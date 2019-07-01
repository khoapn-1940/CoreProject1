class SelfManagementController < ApplicationController
  def view_my_booking
    @my_booking = current_user.bookings.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
  end

  def delete_my_booking
    @my_booking = current_user.bookings.find_by_id params[:booking_id]
    if @my_booking.destroy
      respond_to do |format|
        format.html{redirect_to view_my_booking_path}
        format.js
      end
    else
      flash[:danger] = "Delete Booking Failed"
      redirect_to view_my_booking_path
    end
  end
  
  def view_my_review
    @my_review = current_user.reviews.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
  end

  def delete_my_review
    @my_review = current_user.reviews.find_by_id params[:review_id]
    if @my_review.destroy
      respond_to do |format|
        format.html{redirect_to view_my_booking_path}
        format.js
      end
    else
      flash[:danger] = "Delete Review Failed"
      redirect_to view_my_booking_path
    end
  end

  def view_my_information
    @user = current_user
    render :view_information
  end

  def view_other_user_information
    @user = User.find_by_id params[:user_id]
    render :view_information
  end

  def edit_my_information
    @user = current_user
  end

  def update_my_information
    if @user.update_attributes(update_params)
      flash[:success] = "Update Successfully"
    else
      flash[:danger] = "Update Failed"
    end
    redirect_to view_my_information_path
  end

  private

  def update_params
    params.require(:user).permit :name, :email, :phone, :bank_account
  end
end
