class SubscriptionsController < Buyer::BaseController
  before_action :set_plan, only: :create

  def index
    @subscriptions = current_user.subscriptions.includes(:plan)
  end

  def create
    subscription = current_user.subscriptions.build(
      plan: @plan,
      started_at: Time.current
    )

    if subscription.save
      redirect_to subscriptions_path, notice: "Subscription created successfully"
    else
      redirect_to plans_path, alert: subscription.errors.full_messages.to_sentence
    end
  end

  private

  def set_plan
    @plan = Plan.find(params[:plan_id])
  end
end
