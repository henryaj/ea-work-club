task :send_weekly_updates => :environment do
  require 'logger'

  logger = Logger.new(STDOUT)
  logger.level = Logger::INFO

  subscribed_users = User.all.select do |u|
    u.subscribed?
  end

  subscribed_users.each do |u|
    logger.info("Sending weekly update to #{u.email}")
    UserMailer.weekly_listing_update_email(u).deliver_now
  end
end
