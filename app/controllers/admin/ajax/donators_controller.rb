class Admin::Ajax::DonatorsController < ApplicationController
# class Admin::Ajax::DonatorsController < Admin::BaseController
  # skip_load_and_authorize_resource
  # authorize_resource User

  def index
    @q = User.blood_type_compatible_with(patient_blood_type).ransack params[:q]
    @donators = @q.result.decorate
  end

  def show
    user = User.find_by id: params[:id]
    if user
      histories = user.histories
      render json: {data: histories}, status: 200
    else
      render json: {}, status: 404
    end
  end

  private
  def patient_blood_type
    Settings.blood_recipient_scheme.try params[:q][:blood_type_compatible]
  end
end
