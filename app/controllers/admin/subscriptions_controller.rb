<<<<<<< HEAD
class Admin::SubscriptionsController < Admin::BaseController
  before_action :set_subscription, only: :show

  def index
    @pagy, @subscriptions = pagy(:offset, subscriptions)
  end

  def show; end
=======
class Admin::SubscriptionsController < ApplicationController
  include AdminAuthorization

  layout "admin"

  before_action :set_subscription, only: :show

  def index
    @subscriptions = Subscription.includes(
      :user,
      :plan,
      :subscription_statuses,
      usage_entries: { plan_feature: :feature }
    )
  end

  def show
  end
>>>>>>> 82aa26e (feat (admin crud): Implement admin management for plans and features)

  private

  def set_subscription
<<<<<<< HEAD
    @subscription = subscriptions.find(params[:id])
  end

  def subscriptions
    Subscription.with_details
=======
    @subscription = Subscription.includes(
      :user,
      :plan,
      :subscription_statuses,
      usage_entries: { plan_feature: :feature }
    ).find(params[:id])
>>>>>>> 82aa26e (feat (admin crud): Implement admin management for plans and features)
  end
end
