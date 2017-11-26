class PagesController < ApplicationController
  def index
    @current_user = session[:userinfo]
    @jobs = Job.first(10)
  end

  def about
  end
end
