class Feature < ApplicationRecord
  has_many :plan_features, dependent: :destroy
  has_many :plans, through: :plan_features

  validates :name, presence: true
  validates :code, presence: true, uniqueness: true
<<<<<<< HEAD
  validates :unit_price, numericality: { greater_than_or_equal_to: 0 }
  validates :max_unit_limit, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
=======
  validates :unit_price,
            numericality: { greater_than_or_equal_to: 0 },
            allow_nil: true
  validates :max_unit_limit,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 0
            },
            allow_nil: true
>>>>>>> 82aa26e (feat (admin crud): Implement admin management for plans and features)
end
