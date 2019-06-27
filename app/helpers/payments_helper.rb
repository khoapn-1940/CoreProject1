module PaymentsHelper
  def not_paid id
    if Payment.where(booking_id: id).empty?
      return true
    else
      return false
    end
  end
end
