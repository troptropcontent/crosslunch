class ApplicationController < ActionController::Base
  helper_method :require_subdomain
  helper_method :load_company
  helper_method :authenticate_employee

  private

  def load_company
    @company = Company.find_by(name: request.subdomain)
  end

  def require_subdomain
    not_found unless subdomain_exist?
  end

  def subdomain_exist?
    company = Company.find_by(name: request.subdomain)
    !!company
  end

  def not_found
    raise ActionController::RoutingError, '404'
  end

  def current_employee
    Employee.find_by(id: session[:employee_id])
  end

  def logged_in?
    !current_employee.nil?
  end

  def authenticate_employee
    redirect_to '/login' unless logged_in?
  end
end
