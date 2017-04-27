class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied, ActiveRecord::RecordNotFound do
    respond_to do |format|
      format.html {render_404 if Rails.env.production?}
      format.js {render js: "showNotification('404: Không tìm thấy trang yêu cầu.', 'danger');"}
    end
  end

  def after_sign_in_path_for resource
    admin_page = admin_root_path if current_user.admin? || current_user.limited?
    request.env['omniauth.origin'] || admin_page || stored_location_for(resource) || root_path
  end

  protected
  def render_404
    render "shared/404", status: 404
  end
end
