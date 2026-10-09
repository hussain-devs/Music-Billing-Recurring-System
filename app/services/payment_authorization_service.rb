
class PaymentAuthorizationService
  def initialize(user)
    @user = user
  end

  def create_payment_setup_intent!
    payment_authorization = find_or_build_payment_authorization
    customer = find_or_create_customer(payment_authorization)

    create_setup_intent(customer, payment_authorization)
  end

  def confirm_payment_setup_intent(payment_setup_intent_id)
    payment_authorization = @user.payment_authorization
    setup_intent = Stripe::SetupIntent.retrieve(payment_setup_intent_id)

    return false unless valid_customer?(payment_authorization, setup_intent)

    authorize_payment_method(payment_authorization, setup_intent)
  end

  private

  def create_setup_intent(customer, payment_authorization)
    intent = Stripe::SetupIntent.create(
      customer: customer.id,
      payment_method_types: [ payment_authorization.payment_method_type ]
    )
    payment_authorization.update!(stripe_customer_id: customer.id)
    intent
  end

  def authorize_payment_method(payment_authorization, setup_intent)
    return false unless setup_intent.status == "succeeded"

    payment_authorization.update!(
      stripe_payment_method_id: setup_intent.payment_method,
      authorized: true
    )
    true
  end

  def find_or_build_payment_authorization
    @user.payment_authorization || @user.build_payment_authorization
  end

  def find_or_create_customer(payment_authorization)
    return Stripe::Customer.retrieve(payment_authorization.stripe_customer_id) if
      payment_authorization.stripe_customer_id.present?

    Stripe::Customer.create(email: @user.email, name: @user.name)
  end

  def valid_customer?(payment_authorization, setup_intent)
    payment_authorization &&
      setup_intent.customer == payment_authorization.stripe_customer_id
  end
end
