class RecurringEvent < ApplicationRecord
  validates :group_size, numericality: { greater_than: 0, less_than_or_equal_to: 10 }
  validates :name, uniqueness: { scope: :company_id }
  belongs_to :company
end
