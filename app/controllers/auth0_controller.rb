class Auth0Controller < ApplicationController
  def callback
    session[:userinfo] = request.env['omniauth.auth'].except("extra")

    find_or_create_user(session[:userinfo].fetch("uid"))

    redirect_to root_path
  end

  def failure
    @error_msg = request.params['message']
  end
end
