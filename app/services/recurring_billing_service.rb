class RecurringBillingService
  MAX_RETRIES = 3

  def initialize(user, subscription, date = Date.current)
    @user = user
    @subscription = subscription
    @date = date
  end

  def call
    return false if already_billed?

    payment_intent = create_payment_intent

    create_transaction(
      amount: billing_amount,
      status: :successful,
      stripe_payment_id: payment_intent.id
    )

    true
  rescue Stripe::CardError => e
    handle_billing_failure(stripe_payment_id: e.payment_intent&.id)
  rescue Stripe::StripeError
    handle_billing_failure
  rescue StandardError => e
    Rails.logger.error("Recurring billing failed: #{e.class}: #{e.message}")
    false
  end

  private

  def already_billed?
    @subscription.transactions
      .where(transaction_type: "recurring", status: :successful)
      .where(occurred_at: @date.beginning_of_day..@date.end_of_day)
      .exists?
  end

  def payment_authorization
    @payment_authorization ||= @user.payment_authorization
  end

  def billing_amount
    @subscription.plan.monthly_fee
  end

  def create_payment_intent
    retries = 0

    begin
      Stripe::PaymentIntent.create(
        {
          amount: amount_in_cents(billing_amount),
          currency: "usd",
          customer: payment_authorization.stripe_customer_id,
          payment_method: payment_authorization.stripe_payment_method_id,
          off_session: true,
          confirm: true
        },
        {
          idempotency_key: "recurring-billing-#{@user.id}-#{@subscription.id}-#{@date}"
        }
      )
    rescue Stripe::APIConnectionError
      retries += 1
      retry if retries < MAX_RETRIES

      raise
    end
  end

  def amount_in_cents(amount)
    (amount.to_d * 100).round
  end

  def create_transaction(amount:, status:, stripe_payment_id:)
    @user.transactions.create!(
      subscription: @subscription,
      amount: amount,
      status: status,
      transaction_type: "recurring",
      stripe_payment_id: stripe_payment_id,
      occurred_at: Time.current
    )
  end

  def handle_billing_failure(stripe_payment_id: nil)
    create_transaction(
      amount: billing_amount,
      status: :failed,
      stripe_payment_id: stripe_payment_id
    )

    halt_subscription

    false
  end

  def halt_subscription
    @subscription.subscription_statuses.create!(
      status: :halted,
      is_using: false
    )
  end
end
