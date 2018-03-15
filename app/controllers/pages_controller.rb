class PagesController < ApplicationController
  def index
    @categories = Category.all_except_empty
    @jobs = Job.order(created_at: :desc).reject(&:expired?).first(10)

    date_sorted_projects = Project.all.first(20)

    @projects = date_sorted_projects.sort_by {|p| p.votes_for.size}.reverse
  end

  def about
  end

  def search
    @query = html_escape(params["query"])
    results = PgSearch.multisearch(@query)
    results = results.map { |r| r.searchable }
    @expired_results, @results = results.partition { |r| r.expired? }
  end

  def location_search
    @query = html_escape(params["query"])
    @radius = 50 # miles
    results = Job.near(@query, @radius)
    @expired_results, @results = results.partition { |r| r.expired? }
  end
end
