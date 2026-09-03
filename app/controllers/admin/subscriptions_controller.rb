class Admin::SubscriptionsController < Admin::BaseController
  before_action :set_subscription, only: :show

  def index
    @pagy, @subscriptions = pagy(:offset, subscriptions)
  end

  def show; end

  private

  def set_subscription
    @subscription = subscriptions.find(params[:id])
  end

  def subscriptions
    Subscription.with_details
    @subscription = Subscription.includes(
      :user,
      :plan,
      :subscription_statuses,
      usage_entries: { plan_feature: :feature }
    ).find(params[:id])
  end
end
