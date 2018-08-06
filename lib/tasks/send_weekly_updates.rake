task :send_weekly_updates => :environment do
  require 'logger'

  logger = Logger.new(STDOUT)
  logger.level = Logger::INFO
  live = ENV["LIVE"]
  override_sunday_check = ENV["OVERRIDE_SUNDAY_CHECK"]

  unless override_sunday_check
    if Time.now.wday != 7
      logger.info("Today isn't Sunday, my dudes. Exiting.")
      exit
    end
  end

  if live
    subscribed_users = User.all.select do |u|
      u.subscribed?
    end

    subscribed_users.each do |u|
      logger.info("Sending weekly update to #{u.email}")
      UserMailer.weekly_listing_update_email(u).deliver_now
    end
  else
    User.where(admin: true).each do |u|
      logger.info("Sending weekly update to #{u.email}")
      UserMailer.weekly_listing_update_email(u).deliver_now
    end
  end
end
