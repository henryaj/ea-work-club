class Auth0Controller < ApplicationController
  def callback
    session[:userinfo] = request.env['omniauth.auth']

    user_uid = session[:userinfo].fetch("uid")
    user_info = session[:userinfo].fetch("info")

    user_name = user_info.fetch("name")
    user_email = user_info.fetch("email")

    unless User.where(:uid => user_uid).any?
      User.create(uid: user_uid, name: user_name, email: user_email)
    end

    redirect_to root_path
  end

  def failure
    @error_msg = request.params['message']
  end
end
