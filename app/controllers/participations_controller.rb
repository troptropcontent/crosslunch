class ParticipationsController < ApplicationController
  before_action :authenticate_employee
  before_action :require_subdomain
  def create
    @participation = Participation.create(participation_param)

    respond_to do |format|
      format.html { redirect_to root_path }
      format.turbo_stream
    end
  end

  def destroy
    @participation = Participation.find(params[:id])
    @participation.destroy

    respond_to do |format|
      format.html { redirect_to root_path }
      format.turbo_stream
    end
  end

  private

  def participation_param
    params.require(:participation).permit(:employee_id, :event_id)
  end
end
