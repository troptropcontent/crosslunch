require 'active_support/testing/time_helpers'
class ApplicationController < ActionController::Base
  include ActiveSupport::Testing::TimeHelpers
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  around_action :freeze_time_on

  private

  def not_found
    raise ActionController::RoutingError, '404'
  end

  def freeze_time_on(&block)
    return yield unless Rails.env.development? && ENV['FREEZE_TIME_ON']

    travel_to DateTime.parse(ENV['FREEZE_TIME_ON']), &block
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:last_name, :first_name, :email, :password) }

    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:last_name, :first_name, :email, :password, :current_password)
    end
  end
end
