class SendWeeklyEmailsJob
  include Sidekiq::Job

  def perform(*args)
    users = User.select { |u| u.email != nil }

    users.each do |u|
      expiring_listings = u.jobs_needing_renewal + u.projects_needing_renewal

      if expiring_listings.any?
        logger.info("Sending renewal reminder to #{u.email}")
        UserMailer.listing_renewal_reminder(u, expiring_listings).deliver_now
      end
    end

    subscribed_users = User.all.select do |u|
      u.subscribed?
    end

    subscribed_users.each do |u|
      logger.info("Sending weekly update to #{u.email}")
      begin
        UserMailer.weekly_listing_update_email(u).deliver_now
      rescue => e
        Raven.capture_exception(e)
      end
    end
  end
end
