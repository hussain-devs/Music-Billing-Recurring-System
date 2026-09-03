<<<<<<< HEAD
class Admin::PlanFeaturesController < Admin::BaseController
  include CrudResponseHandling
=======
class Admin::PlanFeaturesController < ApplicationController
  include AdminAuthorization

  layout "admin"
>>>>>>> 82aa26e (feat (admin crud): Implement admin management for plans and features)

  before_action :set_plan

  def create
<<<<<<< HEAD
    plan_feature = @plan.plan_features.build(plan_feature_params)

    handle_crud_result(
      plan_feature,
      success_path: admin_plan_path(@plan),
      success_message: "Feature added to plan."
    ) do
      plan_feature.save
=======
    @plan_feature = @plan.plan_features.build(plan_feature_params)

    if @plan_feature.save
      redirect_to admin_plan_path(@plan), notice: "Feature added to plan."
    else
      redirect_to admin_plan_path(@plan),
                  alert: @plan_feature.errors.full_messages.to_sentence
>>>>>>> 82aa26e (feat (admin crud): Implement admin management for plans and features)
    end
  end

  def destroy
<<<<<<< HEAD
    plan_feature = @plan.plan_features.find(params[:id])

    handle_crud_result(
      plan_feature,
      success_path: admin_plan_path(@plan),
      success_message: "Feature removed from plan."
    ) do
      plan_feature.destroy
    end
=======
    @plan_feature = @plan.plan_features.find(params[:id])
    @plan_feature.destroy

    redirect_to admin_plan_path(@plan), notice: "Feature removed from plan."
>>>>>>> 82aa26e (feat (admin crud): Implement admin management for plans and features)
  end

  private

  def set_plan
    @plan = Plan.find(params[:plan_id])
  end

  def plan_feature_params
<<<<<<< HEAD
    params.expect(plan_feature: [ :feature_id, :max_unit_price ])
=======
    params.require(:plan_feature).permit(:feature_id, :max_unit_price)
>>>>>>> 82aa26e (feat (admin crud): Implement admin management for plans and features)
  end
end
