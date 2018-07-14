class UserMailer < ApplicationMailer
  default from: "EA Work Club <hello@eawork.club>",
          reply_to: "Henry Stanley <henry@henrystanley.com>"

  def welcome_email(user)
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

    return unless @categories.present?

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

  def listing_update_email_since(user, date_since)
    subscription = user.subscription
    @categories = subscription.categories

    return unless @categories.present?

    @jobs = @categories.map do |category|
      category.jobs_created_since(date_since)
    end.flatten

    @projects = @categories.map do |category|
      category.projects_created_since(date_since)
    end.flatten

    return unless @jobs.present? || @projects.present?

    @unsubscribe_url = "http://www.eawork.club/unsubscribe"
    @header = "Your EA Work Club update"
    @subject = "Your EA Work Club update"

    @body_paragraphs = [
      "Below are new jobs and projects posted on the EA Work Club since #{date_since.to_s}."
    ]

    @closing_paragraphs = [
      "As a reminder, you're signed up to receive alerts for the following categories:",
      @categories.collect(&:name).join(', '),
      "All the best,",
      "EA Work Club"
    ]

    mail(to: user.email, subject: @subject)
  end

  def listing_renewal_reminder(user, listings)
    # see if the user has any listings
    # for each listing, if it is unexpired
    # AND if it has been up for > 2 months
    # send an email with a link to renew it
    @unsubscribe_url = "http://www.eawork.club/unsubscribe"
    @closing_paragraphs = []

    @header = "EA Work Club - listing expiring soon"
    @subject = "EA Work Club - listing expiring soon"

    @listings = listings

    @body_paragraphs = [
      "Hi!",
      "We've got a new policy at EA Work Club to make sure all the listings are as fresh as can be – we'll be expiring listings after 60 days.",
      "The following listings have been up for longer than 60 days. Click on the 'Renew' link beside any listing to renew it for another 60 days."
    ]

    mail(to: user.email, subject: @subject)
  end

  def generic_email(user, subject, body_paragraphs)
    @unsubscribe_url = "http://www.eawork.club/unsubscribe"
    @closing_paragraphs = []

    @header = subject
    @subject = subject

    @body_paragraphs = body_paragraphs

    mail(to: user.email, subject: @subject)
  end
end
