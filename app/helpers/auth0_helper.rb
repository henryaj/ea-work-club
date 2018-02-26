module Auth0Helper
  def user_signed_in?
    session[:userinfo].present?
  end

  def user_is_admin?
    if user_signed_in?
      authenticate_user!
      current_user_db_record.admin?
    end
  end

  def current_user_name
    if user_signed_in?
      authenticate_user!
      @current_user.fetch("info").fetch("name")
    end
  end

  def current_user_db_record
    if user_signed_in?
      authenticate_user!

      return find_or_create_user(current_user_id)
    end
  end

  def current_user_id
    if user_signed_in?
      authenticate_user!
      @current_user.fetch("uid")
    end
  end

  def find_or_create_user(uid)
    user_info = session[:userinfo].fetch("info")
    user_name = user_info.fetch("name")
    user_email = user_info.fetch("email")

    user = User.where(:uid => uid).first || User.new
    user.uid = uid
    user.name = user_name
    user.email = user_email
    user.save

    return user
  end

  def authenticate_user!
    if user_signed_in?
      @current_user = session[:userinfo]
    else
      flash[:notice] = "You need to be <a href='/auth/auth0'>logged in</a> to do that."
      redirect_back(fallback_location: root_path)
    end
  end
end
