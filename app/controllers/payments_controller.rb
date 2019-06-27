class PaymentsController < ApplicationController
  def pay
    @payment = Payment.new(:booking_id => params[:booking_id])
    if not_paid params[:booking_id]
      pay_banking
    else
      flash[:danger] = "Booking has been paid"
    end
    redirect_to view_booking_request_path
  end

  private

  def pay_banking
    if @payment.save
      flash[:success] = "Pay success"
    else
      flash[:danger] = "Pay failed"
    end
    true
  end
end
