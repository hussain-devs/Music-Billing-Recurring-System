class Invitation < ApplicationRecord
  belongs_to :inviter, class_name: "User", foreign_key: :inviter_id

  validates :email, presence: true
  validates :token, presence: true, uniqueness: true

  before_validation :generate_token, on: :create

  private

  def generate_token
    self.token = SecureRandom.urlsafe_base64
  end
end
