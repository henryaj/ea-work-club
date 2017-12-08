class UserMailer < ApplicationMailer
  default from: 'hello@eawork.club'

  def welcome_email(user)
    formatted_subscription_names = user.all_subscription_names.map do |s|
      "<li>" + s + "</li>"
    end

    @unsubscribe_url = "http://www.eawork.club/unsubscribe"
    @header = "Thanks for signing up for EA Work Club alerts"
    @body_paragraphs = [
      "Welcome!",
      "It's great to have you. You've signed up to email alerts – we'll keep you up to date with the latest EA jobs and projects.",
      "You've said you want to be alerted about the following categories:"
    ]
    @subscription_names = user.all_subscription_names
    @closing_paragraphs = [
      "All the best,",
      "EA Work Club"
    ]
    @subject = "Welcome to EA Work Club!"

    mail(to: user.email, subject: @subject)
  end
end
