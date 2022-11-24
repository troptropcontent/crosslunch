class Company < ApplicationRecord
  validates :name, format: { with: /\A[a-zA-Z-]+\z/,
                             message: 'only allows letters and dashes' }

  has_many :recurring_events
end
