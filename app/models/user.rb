class User < ApplicationRecord
  devise :database_authenticatable,
         :recoverable,
         :rememberable,
         :validatable

  belongs_to :role

  has_many :subscriptions, dependent: :destroy
  has_many :transactions, dependent: :destroy

  has_one :payment_authorization, dependent: :destroy

  has_many :sent_invitations, class_name: "Invitation", foreign_key: :inviter_id, dependent: :destroy

  has_one_attached :profile_photo

  validate :profile_photo_type_and_size

  validates :name, presence: true

  validates :billing_day, numericality: { only_integer: true, in: 1..30 }, allow_nil: true

  scope :buyers, -> { joins(:role).where(roles: { role: "Buyer" }) }

  def admin? = role.role == "Admin"

  def buyer? = role.role == "Buyer"

  private

  def profile_photo_type_and_size
    return unless profile_photo.attached?

    unless profile_photo.content_type.in?(%w[image/png image/jpeg image/webp])
      errors.add(:profile_photo, "must be a PNG, JPEG, or WebP image")
    end

    if profile_photo.byte_size > 5.megabytes
      errors.add(:profile_photo, "must be less than 5 MB")
    end
  end
end
