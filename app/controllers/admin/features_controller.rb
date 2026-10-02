class Admin::FeaturesController < Admin::BaseController
  before_action :set_feature, only: %i[show edit update destroy]

  def index
    authorize Feature
    @pagy, @features = pagy(:offset, Feature.all)
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
      redirect_to admin_features_path,
                  alert: @feature.errors.full_messages.to_sentence
    end
  end

  private

  def set_feature
    @feature = Feature.find(params[:id])
  end

  def feature_params
    params.expect(feature: [ :name, :code, :unit_price, :max_unit_limit ])
  end
end
