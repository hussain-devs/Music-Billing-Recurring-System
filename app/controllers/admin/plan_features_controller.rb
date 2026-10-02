class Admin::PlanFeaturesController < Admin::BaseController
  include CrudResponseHandling

  before_action :set_plan

  def create
    plan_feature = @plan.plan_features.build(plan_feature_params)
    authorize plan_feature

    handle_crud_result(
      plan_feature,
      success_path: admin_plan_path(@plan),
      success_message: "Feature added to plan."
    ) do
      plan_feature.save
    end
  end

  def destroy
    plan_feature = @plan.plan_features.find(params[:id])
    authorize plan_feature

    handle_crud_result(
      plan_feature,
      success_path: admin_plan_path(@plan),
      success_message: "Feature removed from plan."
    ) do
      plan_feature.destroy
    end
  end

  private

  def set_plan
    @plan = Plan.find(params[:plan_id])
  end

  def plan_feature_params
    params.expect(plan_feature: [ :feature_id, :max_unit_price ])
  end
end
