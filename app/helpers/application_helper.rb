module ApplicationHelper
  def full_title page_title
    base_title = I18n.t "helper.basetitle"
    if page_title.blank?
      base_title
    else
      page_title + base_title
    end
  end

  def check_admin
    redirect_to error_path unless User.roles[session[:role]] == User.roles[:admin]
  end
end
