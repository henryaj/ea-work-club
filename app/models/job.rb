class Job < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_rich_text :content

  geocoded_by :location
  after_validation :geocode

  include PgSearch
  multisearchable against: %i(title organisation description owner_name)

  is_impressionable

  enum time_commitment: [:not_specified, :part_time, :full_time]

  def views
    impressionist_count(filter: :ip_address)
  end

  def self.displayable_newest_first
    all.order(created_at: :desc).reject(&:expired?)
  end

  def self.displayable_sorted_by_expiry
    all.order(expiry_date: :asc).reject(&:expired?)
  end

  def expired?
    return true if last_renewed_ago_days > 70
    return expiry_date.past?  if expiry_date

    false
  end

  def remote?
    remote
  end

  def expires_soon?
    return expiry_date.days_since(-7).past?  if expiry_date

    false
  end

  def preview
    Nokogiri::HTML(pretty_description).text.truncate(85)
  end

  def pretty_description
    return format(description).html_safe if description

    content.to_s
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

    last_renewed_ago_days > 60 && last_renewed_ago_days < 68
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
