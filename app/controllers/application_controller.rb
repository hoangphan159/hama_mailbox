class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :signed_in?
  helper_method :skip_if_logged_in

  def gravatar_url(email, size)
    gravatar = Digest::MD5::hexdigest(email).downcase
    "http://gravatar.com/avatar/#{gravatar}.png?s=#{size}"
  end

  def signed_in?
    current_user.present?
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def require_login
    if !signed_in?
      flash[:notice] = "Please login!"
      redirect_to new_session_path
    end
  end

  def skip_if_logged_in
    if signed_in?
      redirect_to users_path
    end
  end

end
