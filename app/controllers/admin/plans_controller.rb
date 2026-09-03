<<<<<<< HEAD
class Admin::PlansController < Admin::BaseController
  include CrudResponseHandling
  before_action :set_plan, only: %i[ update destroy ]

  def index
    @pagy, @plans = pagy(:offset, Plan.all)
=======
class Admin::PlansController < ApplicationController
  include AdminAuthorization

  layout "admin"

  before_action :set_plan, only: [ :show, :edit, :update, :destroy ]

  def index
    @plans = Plan.all
>>>>>>> 82aa26e (feat (admin crud): Implement admin management for plans and features)
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

<<<<<<< HEAD
=======
  def show
  end

  def edit
  end

>>>>>>> 82aa26e (feat (admin crud): Implement admin management for plans and features)
  def update
    if @plan.update(plan_params)
      redirect_to admin_plan_path(@plan), notice: t("plans.update.success")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
<<<<<<< HEAD
    handle_crud_result(
      @plan,
      success_path: admin_plans_path,
      success_message: t("plans.destroy.success")
    ) do
      @plan.destroy
=======
    if @plan.destroy
      redirect_to admin_plans_path, notice: t("plans.destroy.success")
    else
      redirect_to admin_plans_path, alert: @plan.errors.full_messages.to_sentence
>>>>>>> 82aa26e (feat (admin crud): Implement admin management for plans and features)
    end
  end

  private

  def set_plan
    @plan = Plan.find(params[:id])
  end

  def plan_params
<<<<<<< HEAD
    params.expect(plan: [ :name, :monthly_fee ])
=======
    params.require(:plan).permit(:name, :monthly_fee)
>>>>>>> 82aa26e (feat (admin crud): Implement admin management for plans and features)
  end
end
