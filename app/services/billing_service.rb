class BillingService
  def initialize(date = Date.current)
    @date = date
  end

  def call
    eligible_users.find_each do |user|
      charge_user!(user)
    end
  end

  private

  def eligible_users
    User.where.not(billing_day: nil)
      .includes(subscriptions: :subscription_statuses)
  end

  def charge_user!(user)
    return unless due_today?(user.billing_day)

    user.subscriptions.each do |subscription|
      next unless subscription.active?

      charge_subscription(user, subscription)
    end
  end

  def due_today?(billing_day)
    billing_date_for(billing_day) == @date
  end

  def billing_date_for(billing_day)
    last_day = @date.end_of_month.day
    day = [ billing_day, last_day ].min

    @date.change(day: day)
  end

  def charge_subscription(user, subscription)
    RecurringBillingService.new(user, subscription, @date).call
  end
end
