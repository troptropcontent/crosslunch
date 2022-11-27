class SessionsController < ApplicationController
  before_action :require_subdomain
  before_action :load_company

  # POST /login => with company subdomain
  def create
    @employee = @company.employees.find_or_create_by(
      first_name: session_params[:first_name]&.strip,
      last_name: session_params[:last_name]&.strip
    )
    session[:employee_id] = @employee.id
    redirect_to root_path
  end

  private

  def session_params
    params.require(:session).permit(:last_name, :first_name)
  end
end
