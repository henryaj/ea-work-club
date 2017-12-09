class ApplicationController < ActionController::Base
  include Auth0Helper
  protect_from_forgery with: :exception
  before_action :set_raven_context

  private

  def set_raven_context
    if user_signed_in?
      Raven.user_context(
        signed_in: true,
        name: session[:userinfo]["info"]["name"],
        email: session[:userinfo]["info"]["email"],
        userinfo: session[:userinfo]["info"]
      )
    else
      Raven.user_context(
        signed_in: false
      )
    end
  end
end
