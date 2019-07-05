module PaysHelper
  def paid? id
    return true if current_user.bookings.find_by_id(id).payments.first
    false
  end
end
