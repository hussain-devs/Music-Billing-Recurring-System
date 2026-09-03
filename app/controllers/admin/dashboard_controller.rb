# frozen_string_literal: true

<<<<<<< HEAD
class Admin::DashboardController < Admin::BaseController
  def index
    authorize :dashboard, :index?, policy_class: DashboardPolicy

    @plans_count = Plan.all.size
    @features_count = Feature.all.size
    @subscriptions_count = Subscription.all.size
=======
class Admin::DashboardController < ApplicationController
  include AdminAuthorization

  layout "admin"

  def index
    @plans_count = Plan.count
    @features_count = Feature.count
    @subscriptions_count = Subscription.count
    @buyers_count = User.joins(:role).where(roles: { role: "Buyer" }).count
>>>>>>> 82aa26e (feat (admin crud): Implement admin management for plans and features)
  end
end
