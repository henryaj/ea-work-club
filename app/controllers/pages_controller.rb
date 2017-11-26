class PagesController < ApplicationController
  def index
    @current_user = session[:userinfo]
    @jobs = Job.first(10)
  end
end
