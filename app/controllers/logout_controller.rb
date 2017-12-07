class LogoutController < ApplicationController
  def logout
    reset_session
    flash[:notice] = "You're now logged out."
    redirect_to root_path
  end
end
