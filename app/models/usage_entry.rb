class UsageEntry < ApplicationRecord
  belongs_to :subscription
  belongs_to :plan_feature

  after_create_commit :notify_usage_limit

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }

  validate :plan_feature_belongs_to_subscription

  private

  def notify_usage_limit
    previous_usage = plan_feature.usage_for(subscription) - quantity

    UsageLimitNotifier.call(
      subscription: subscription,
      plan_feature: plan_feature,
      previous_usage: previous_usage
    )
  end

  def plan_feature_belongs_to_subscription
    return if subscription.blank? || plan_feature.blank?

    unless subscription.plan_id == plan_feature.plan_id
      errors.add(:plan_feature, "does not belong to the subscription's plan")
    end
  end
end
