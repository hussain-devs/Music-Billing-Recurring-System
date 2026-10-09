class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :plan

  has_many :subscription_statuses, dependent: :destroy
  has_many :usage_entries, dependent: :destroy
  has_many :transactions, dependent: :restrict_with_exception

  validates :started_at, presence: true

  scope :with_details, -> { includes(:user, :plan, :subscription_statuses, usage_entries: { plan_feature: :feature }) }

  validates_with PaymentAuthorizationValidator, on: :create
  validates_with NoActiveDuplicatePlanValidator, on: :create

  scope :active, -> { where(unsubscribed_at: nil) }

  after_create :create_subscription_status

  scope :for_plan, ->(plan_id) { where(plan_id: plan_id) }

  private

  def create_subscription_status
    subscription_statuses.create!(
      status: :active,
      is_using: true
    )
  end
end
