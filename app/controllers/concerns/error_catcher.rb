require 'active_support/concern'

module ErrorCatcher
  extend ActiveSupport::Concern
  # TO DO
  included do
    # rescue_from ActiveRecord::RecordInvalid,
    #               ActiveRecord::DeleteRestrictionError,
    #               ActiveRecord::RecordNotSaved,
    #               ActiveRecord::RecordNotDestroyed,
    #               ActiveModel::ValidationError do |error|
    #     render ... , status: :unprocessable_entity
    # end
  end
end
