class Company < ApplicationRecord
  validates :name, format: { with: /\A[a-zA-Z-]+\z/,
                             message: 'only allows letters and dashes' }

  has_one :recurring_event
  has_many :employees
  has_many :users, through: :employees
end
