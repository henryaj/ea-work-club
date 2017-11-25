class Job < ApplicationRecord
  enum time_commitment: [:not_specified, :part_time, :full_time]

  def preview
    description.lines.reject {|l| l == "\n"}.first + "..."
  end

  def pretty_description
    format(description).html_safe
  end

  def pretty_time_commitment
    time_commitment.humanize
  end

  private

  def format(string)
    Kramdown::Document.new(string).to_html
  end
end
