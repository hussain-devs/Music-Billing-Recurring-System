class PlansController < Buyer::BaseController
  def index
    @plans = Plan.includes(:features).all
  end
end
