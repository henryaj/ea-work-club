class PagesController < ApplicationController
  def index
    @user = session[:userinfo]
    @jobs = Job.first(10)
  end
end
