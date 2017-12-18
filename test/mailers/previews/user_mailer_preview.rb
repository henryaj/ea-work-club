class UserMailerPreview < ActionMailer::Preview
  def welcome_email
    UserMailer.welcome_email(User.last)
  end

  def weekly_listing_update_email
    UserMailer.weekly_listing_update_email(User.last)
  end
end
