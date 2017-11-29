class Job < ApplicationRecord
  belongs_to :user
  belongs_to :category
  enum time_commitment: [:not_specified, :part_time, :full_time]

  def expired?
    if expiry_date
      return expiry_date.past?
    end

    false
  end

  def expires_today?
    if expiry_date
      return expiry_date.today?
    end

    false
  end

  def preview
    Nokogiri::HTML(pretty_description).text.truncate(85)
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
