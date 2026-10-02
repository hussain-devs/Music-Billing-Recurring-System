# frozen_string_literal: true

class Admin::DashboardController < Admin::BaseController
  def index
    authorize :dashboard, :index?, policy_class: DashboardPolicy

    @plans_count = Plan.all.size
    @features_count = Feature.all.size
    @subscriptions_count = Subscription.all.size
  end
end
