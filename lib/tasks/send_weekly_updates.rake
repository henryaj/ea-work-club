task :send_weekly_updates => :environment do
  require 'logger'

  logger = Logger.new(STDOUT)
  logger.level = Logger::INFO
  live = ENV["LIVE"]

  if live
    subscribed_users = User.all.select do |u|
      u.subscribed?
    end

    subscribed_users.each do |u|
      logger.info("Sending weekly update to #{u.email}")
      begin
        UserMailer.weekly_listing_update_email(u).deliver_now
      rescue => e
        Raven.capture_exception(exception)
      end
    end
  else
    User.where(admin: true).each do |u|
      logger.info("Sending weekly update to #{u.email}")
      UserMailer.weekly_listing_update_email(u).deliver_now
    end
  end
end
