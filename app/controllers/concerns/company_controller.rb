require 'active_support/concern'

module CompanyController
  extend ActiveSupport::Concern

  included do
    before_action :require_subdomain

    private

    def require_subdomain
      not_found unless company
    end

    def company
      @company ||= Company.find_by(name: request.subdomain)
    end

    def current_employee
      @current_employee ||= @company.employees.find_or_create_by(user: current_user)
    end
  end
end
