class PagesController < ApplicationController
  def index
    @current_user = session[:userinfo]
    @jobs = Job.order(created_at: :desc).reject(&:expired?).first(10)
    @projects = Project.order(created_at: :desc).first(10)
  end

  def about
  end
end
