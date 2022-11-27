class ParticipationsController < ApplicationController
  before_action :authenticate_employee
  before_action :require_subdomain
  def create
    @participation = Participation.create(participation_param)
    redirect_to root_path
  end

  def destroy
    @participation = Participation.find(params[:id])
    @participation.destroy

    redirect_to root_path
  end

  private

  def participation_param
    params.require(:participation).permit(:employee_id, :event_id)
  end
end
