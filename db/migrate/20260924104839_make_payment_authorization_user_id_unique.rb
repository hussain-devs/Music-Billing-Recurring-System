class MakePaymentAuthorizationUserIdUnique < ActiveRecord::Migration[8.1]
  def change
    remove_index :payment_authorizations, :user_id
    add_index :payment_authorizations, :user_id, unique: true
  end
end
