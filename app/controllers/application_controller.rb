class ApplicationController < ActionController::Base
  include Auth0Helper
  protect_from_forgery with: :exception
  before_action :set_raven_context

  private

  def set_raven_context
    Raven.user_context(
      signed_in: user_signed_in?,
      uid: session[:userinfo]["uid"],
      name: session[:userinfo]["info"]["name"],
      email: session[:userinfo]["info"]["email"],
      userinfo: session[:userinfo]["info"]
    )
  end
end
