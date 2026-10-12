class PlanFeature < ApplicationRecord
  belongs_to :plan
  belongs_to :feature

  has_many :usage_entries, dependent: :destroy

  validates :feature_id, uniqueness: { scope: :plan_id }
  validates :max_unit_price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  def usage_for(subscription)
    usage_entries.where(subscription: subscription).sum(:quantity)
  end

  def usage_exceeded?(subscription)
    max_limit = feature.max_unit_limit

    max_limit.present? && usage_for(subscription) > max_limit
  end
end
