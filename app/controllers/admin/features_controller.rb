<<<<<<< HEAD
class Admin::FeaturesController < Admin::BaseController
  before_action :set_feature, only: %i[show edit update destroy]

  def index
    authorize Feature
    @pagy, @features = pagy(:offset, Feature.all)
=======
class Admin::FeaturesController < ApplicationController
  include AdminAuthorization

  layout "admin"

  before_action :set_feature, only: [ :show, :edit, :update, :destroy ]

  def index
    @features = Feature.all
>>>>>>> 82aa26e (feat (admin crud): Implement admin management for plans and features)
  end

  def new
    @feature = Feature.new
    authorize @feature
  end

  def create
    @feature = Feature.new(feature_params)
    authorize @feature

    if @feature.save
      redirect_to admin_feature_path(@feature), notice: t("features.create.success")
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
    authorize @feature

    if @feature.update(feature_params)
      redirect_to admin_feature_path(@feature), notice: t("features.update.success")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @feature

    if @feature.destroy
      redirect_to admin_features_path, notice: t("features.destroy.success")
    else
<<<<<<< HEAD
      redirect_to admin_features_path,
                  alert: @feature.errors.full_messages.to_sentence
=======
      redirect_to admin_features_path, alert: @feature.errors.full_messages.to_sentence
>>>>>>> 82aa26e (feat (admin crud): Implement admin management for plans and features)
    end
  end

  private

  def set_feature
    @feature = Feature.find(params[:id])
  end

  def feature_params
<<<<<<< HEAD
    params.expect(feature: [ :name, :code, :unit_price, :max_unit_limit ])
=======
    params.require(:feature).permit(
      :name,
      :code,
      :unit_price,
      :max_unit_limit
    )
>>>>>>> 82aa26e (feat (admin crud): Implement admin management for plans and features)
  end
end
