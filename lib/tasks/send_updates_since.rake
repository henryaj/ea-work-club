task :send_updates_since => :environment do
  require 'logger'
  require 'date'

  logger = Logger.new(STDOUT)
  logger.level = Logger::INFO

  since = ENV.fetch("SINCE")
  since_date = Date.parse(since)

  live = ENV["LIVE"]

  if live
    subscribed_users = User.all.select do |u|
      u.subscribed?
    end

    subscribed_users.each do |u|
      logger.info("Sending weekly update to #{u.email}")
      UserMailer.weekly_listing_update_email_since(u, since_date).deliver_now
    end
  else
    User.where(admin: true).each do |u|
      logger.info("Sending weekly update to #{u.email}")
      UserMailer.weekly_listing_update_email_since(u, since_date).deliver_now
    end
  end
end
