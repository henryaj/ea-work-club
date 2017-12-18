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

  def weekly_listing_update_email(user)
    subscription = user.subscription
    @categories = subscription.categories
    @jobs = @categories.map do |category|
      category.jobs_created_within_last_week
    end.flatten

    @projects = @categories.map do |category|
      category.projects_created_within_last_week
    end.flatten

    return unless @jobs.present? || @projects.present?

    @unsubscribe_url = "http://www.eawork.club/unsubscribe"
    @header = "Your weekly EA Work Club update"
    @subject = "Your weekly EA Work Club update"

    @body_paragraphs = [
      "Below are new jobs and projects posted on the EA Work Club in the last week."
    ]

    @closing_paragraphs = [
      "As a reminder, you're signed up to receive alerts for the following categories:",
      @categories.collect(&:name).join(', '),
      "All the best,",
      "EA Work Club"
    ]

    mail(to: user.email, subject: @subject)
  end
end
