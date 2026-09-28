class Admin::PlansController < Admin::BaseController
  include CrudResponseHandling
  before_action :set_plan, only: %i[ update destroy ]

  def index
    @pagy, @plans = pagy(:offset, Plan.all)
  end

  def new
    @plan = Plan.new
  end

  def create
    @plan = Plan.new(plan_params)

    if @plan.save
      redirect_to admin_plan_path(@plan), notice: t("plans.create.success")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @plan.update(plan_params)
      redirect_to admin_plan_path(@plan), notice: t("plans.update.success")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    handle_crud_result(
      @plan,
      success_path: admin_plans_path,
      success_message: t("plans.destroy.success")
    ) do
      @plan.destroy
    end
  end

  private

  def set_plan
    @plan = Plan.find(params[:id])
  end

  def plan_params
    params.expect(plan: [ :name, :monthly_fee ])
  end
end
