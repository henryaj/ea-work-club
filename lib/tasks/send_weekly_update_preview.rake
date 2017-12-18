task :send_weekly_update_preview => :environment do
  require 'logger'

  logger = Logger.new(STDOUT)
  logger.level = Logger::INFO

  User.where(admin: true).each do |u|
    logger.info("Sending weekly update to #{u.email}")
    UserMailer.weekly_listing_update_email(u).deliver_now
  end
end
