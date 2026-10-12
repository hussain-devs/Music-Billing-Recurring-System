class Buyer::BaseController < ApplicationController
  layout "buyer"
  before_action :authenticate_user!
  before_action :authorize_buyer

  private

  def authorize_buyer
    redirect_to root_path, alert: "Access Denied" unless current_user.buyer?
  end
end
