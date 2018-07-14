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

  def expired?
    false # TODO
  end

  def renew!
    update(renewed_at: Time.current)
  end

  def needs_renewal_soon?
    return !expired? && (last_renewed_ago_days > 60)
  end

  def last_renewed_ago_days
    ((Time.current - last_renewed_date) / 1.day).round
  end

  private

  def last_renewed_date
    renewed_at.present? ? renewed_at : created_at
  end

  def format(string)
    Kramdown::Document.new(string).to_html
  end
end
