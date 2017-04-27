class Admin::BaseController < BaseController
  layout "application_admin"

  def current_ability
    @current_ability ||= AdminAbility.new current_user
  end

  rescue_from CanCan::AccessDenied do
    if current_user&.admin? || current_user&.limited?
      render_403
    else
      render "shared/404", layout: "application", status: 404
    end
  end

  protected
  def render_404
    render "shared/404_admin", status: 404
  end

  def render_403
    render "shared/403_admin", status: 403
  end
end
