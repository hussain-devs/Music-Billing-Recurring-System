class AddPaymentMethodTypeToPaymentAuthorizations < ActiveRecord::Migration[8.1]
  def change
    add_column :payment_authorizations, :payment_method_type,
               :string, default: "card", null: false
  end
end
