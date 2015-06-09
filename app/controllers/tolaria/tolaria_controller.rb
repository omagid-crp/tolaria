class Tolaria::TolariaController < ::ApplicationController

  protect_from_forgery
  before_filter :add_admin_headers!
  before_filter :authenticate_admin!

  protected

  def add_admin_headers!
    # Don't use old IE rendering modes
    response.headers["X-UA-Compatible"] = "IE=edge"
    # Forbid putting the admin in a frameset/iframe
    response.headers["X-Frame-Options"] = "DENY"
    # Strict sniffing and XSS modes for browsers that use these flags
    response.headers["X-Content-Type-Options"] = "nosniff"
    response.headers["X-XSS-Protection"] = "1; mode=block"
  end

  def tolaria_template(name)
    return {
      template: "admin/tolaria_resource/#{name}",
      layout: "admin/admin"
    }
  end

  def authenticate_admin!
    unless current_administrator
      flash[:error] = "You must log in to continue. Request a passcode below."
      return redirect_to(admin_new_session_path, status:303)
    end
  end

  def current_administrator
    @current_administrator ||= Administrator.find_by_auth_token(cookies.encrypted[:admin_auth_token])
  end

  helper_method :current_administrator

end
