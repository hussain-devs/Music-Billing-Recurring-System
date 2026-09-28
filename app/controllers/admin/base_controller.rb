class Admin::BaseController < ApplicationController
  layout "admin"

  before_action :authenticate_user!
  before_action :authorize_admin

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def authorize_admin
    authorize :admin, :show?, policy_class: AdminPolicy
  end

  def record_not_found
    redirect_to admin_root_path, alert: "Record not found."
  end
end
