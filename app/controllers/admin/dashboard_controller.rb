# frozen_string_literal: true

class Admin::DashboardController < Admin::BaseController
  def index
    @plans_count = Plan.all.size
    @features_count = Feature.all.size
    @subscriptions_count = Subscription.all.size
    @buyers_count = User.buyers.size
  end
end
