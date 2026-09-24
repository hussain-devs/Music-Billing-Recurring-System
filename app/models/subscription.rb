class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :plan

  has_many :subscription_statuses, dependent: :destroy
  has_many :usage_entries, dependent: :destroy
  has_many :transactions, dependent: :restrict_with_exception

  validates :started_at, presence: true
end
