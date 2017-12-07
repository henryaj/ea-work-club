class Auth0Controller < ApplicationController
  def callback
    session[:userinfo] = request.env['omniauth.auth']

    user_uid = session[:userinfo].fetch("uid")
    user_info = session[:userinfo].fetch("info")

    user_name = user_info.fetch("name")
    user_email = user_info.fetch("email")

    user = User.where(:uid => user_uid).first || User.new
    user.uid = user_uid
    user.name = user_name
    user.email = user_email
    user.save

    redirect_to root_path
  end

  def failure
    @error_msg = request.params['message']
  end
end
