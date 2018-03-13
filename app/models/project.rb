class Project < ApplicationRecord
  belongs_to :user
  belongs_to :category
  acts_as_votable

  include PgSearch
  multisearchable against: %i(title organisation description owner_name)

  def preview
    Nokogiri::HTML(pretty_description).text.truncate(85)
  end

  def pretty_description
    format(description).html_safe
  end

  def created_in_last_week?
    created_at >= Date.today - 7
  end

  private

  def format(string)
    Kramdown::Document.new(string).to_html
  end
end
