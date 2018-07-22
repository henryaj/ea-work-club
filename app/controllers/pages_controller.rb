class PagesController < ApplicationController
  def index
    @categories = Category.all_except_empty
    @jobs = Job.displayable_newest_first.first(10)
    @projects = Project.displayable_newest_first.first(20)
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
