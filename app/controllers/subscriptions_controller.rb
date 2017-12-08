class SubscriptionsController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :create_or_update, :destroy]
  before_action :get_user_subscription, only: [:edit, :create_or_update, :destroy]

  def edit
    @categories = Category.all
  end

  def create_or_update
    @categories = Category.all

    selected_categories = subscription_params.map do |id|
      Category.find(id)
    end

    unless @subscription.categories == selected_categories
      @subscription.categories = selected_categories
      @subscription_changed = true
    end

    if @subscription.save
      UserMailer.welcome_email(current_user_db_record).deliver_later if @subscription_changed
      redirect_to root_path, notice: 'Subscription was successfully updated.'
    else
      render :new
    end
  end

  def destroy
    @subscription.destroy
    redirect_to root_path, notice: "You've been unsubscribed from email alerts."
  end

  private
    def get_user_subscription
      @subscription = current_user_db_record.subscription || Subscription.new(user: current_user_db_record)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subscription_params
      params.require(:category_ids)
    end
end
