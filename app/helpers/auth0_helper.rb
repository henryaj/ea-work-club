module Auth0Helper
  def user_signed_in?
    session[:userinfo].present?
  end

  def current_user_name
    authenticate_user!
    @current_user.fetch("info").fetch("name")
  end

  def current_user_id
    if user_signed_in?
      authenticate_user!
      @current_user.fetch("uid")
    end
  end

  def authenticate_user!
    if user_signed_in?
      @current_user = session[:userinfo]
    else
      flash[:notice] = "You need to be logged in to do that."
      redirect_back(fallback_location: root_path)
    end
  end
end
