class Job < ApplicationRecord
  belongs_to :user
  belongs_to :category

  geocoded_by :location
  after_validation :geocode

  include PgSearch
  multisearchable against: %i(title organisation description owner_name)

  enum time_commitment: [:not_specified, :part_time, :full_time]

  def self.displayable_newest_first
    all.order(created_at: :desc).reject(&:expired?)
  end

  def self.displayable_sorted_by_expiry
    all.order(expiry_date: :asc).reject(&:expired?)
  end

  def expired?
    return true if last_renewed_ago_days > 70

    if expiry_date
      return expiry_date.past?
    end

    false
  end

  def remote?
    remote
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

  def needs_renewal_soon?
    if expiry_date
      return false if expiry_date.past?
    end

    return last_renewed_ago_days > 60 && last_renewed_ago_days < 68
  end

  def last_renewed_ago_days
    ((Time.current - last_renewed_date) / 1.day).round
  end

  def renew!
    update(renewed_at: Time.current)
  end

  private

  def last_renewed_date
    renewed_at.present? ? renewed_at : created_at
  end

  def format(string)
    Kramdown::Document.new(string).to_html
  end
end
