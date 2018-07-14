task :send_listing_renewal_reminders => :environment do
  require 'logger'
  require 'date'

  logger = Logger.new(STDOUT)
  logger.level = Logger::INFO

  live = ENV["LIVE"]

  if live
    users = User.select { |u| u.email != nil }
  else
    users = User.where(admin: true)
  end

  users.each do |u|
    expiring_listings = u.jobs_needing_renewal + u.projects_needing_renewal

    logger.info("Sending renewal reminder to #{u.email}")
    UserMailer.listing_renewal_reminder(u, expiring_listings).deliver_now
  end
end
