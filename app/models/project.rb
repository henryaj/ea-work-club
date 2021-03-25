class Project < ApplicationRecord
  belongs_to :user
  belongs_to :category
  acts_as_votable

  has_rich_text :content

  include PgSearch
  multisearchable against: %i(title organisation description owner_name)

  def self.displayable
    all.reject(&:expired?)
  end

  def self.displayable_sorted_by_votes
    all.reject(&:expired?).sort_by {|p| p.votes_for.size }.reverse
  end

  def self.displayable_newest_first
    all.order(created_at: :desc).reject(&:expired?)
  end

  def self.active
    all.reject(&:expired?)
  end

  def preview
    Nokogiri::HTML(pretty_description).text.truncate(85)
  end

  def pretty_description
    return format(description).html_safe if description

    content.to_s
  end

  def created_in_last_week?
    created_at >= Date.today - 7
  end

  def expired?
    last_renewed_ago_days > 70
    # TODO actual expiry dates
  end

  def renew!
    update(renewed_at: Time.current)
  end

  def needs_renewal_soon?
    last_renewed_ago_days > 60 && last_renewed_ago_days < 68
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
