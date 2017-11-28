class Project < ApplicationRecord
  belongs_to :user
  belongs_to :category
  acts_as_votable

  def preview
    Nokogiri::HTML(pretty_description).text.truncate(85)
  end

  def pretty_description
    format(description).html_safe
  end

  private

  def format(string)
    Kramdown::Document.new(string).to_html
  end
end
