class PagesController < ApplicationController
  def index
    @jobs = Job.order(created_at: :desc).reject(&:expired?).first(10)

    date_sorted_projects = Project.all.first(20)

    @projects = date_sorted_projects.sort_by {|p| p.votes_for.size}.reverse
  end

  def about
  end
end
