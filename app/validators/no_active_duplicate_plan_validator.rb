class NoActiveDuplicatePlanValidator < ActiveModel::Validator
  def validate(record)
    if record.user.subscriptions.active.for_plan(record.plan_id).exists?
      record.errors.add(:plan, "already exists")
    end
  end
end
