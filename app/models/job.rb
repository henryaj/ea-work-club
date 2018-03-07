class Job < ApplicationRecord
  belongs_to :user
  belongs_to :category

  geocoded_by :location
  after_validation :geocode

  enum time_commitment: [:not_specified, :part_time, :full_time]

  def expired?
    if expiry_date
      return expiry_date.past?
    end

    false
  end

  def expires_soon?
    if expiry_date
      return expiry_date.days_since(-7).past?
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

  def created_in_last_week?
    created_at >= Date.today - 7
  end

  private

  def format(string)
    Kramdown::Document.new(string).to_html
  end
end
