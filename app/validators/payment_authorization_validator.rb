class PaymentAuthorizationValidator < ActiveModel::Validator
  def validate(record)
    unless record.user.payment_authorization&.authorized?
      record.errors.add(:base, "Payment Authorization is required")
    end
  end
end
