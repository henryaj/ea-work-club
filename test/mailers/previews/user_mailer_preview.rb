class UserMailerPreview < ActionMailer::Preview
  def welcome_email
    UserMailer.welcome_email(User.last)
  end

  def weekly_listing_update_email
    UserMailer.weekly_listing_update_email(User.last)
  end
  
  def listing_renewal_reminder
    UserMailer.listing_renewal_reminder(User.last, User.last.jobs)
  end
end
