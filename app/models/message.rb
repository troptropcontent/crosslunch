class Message < ApplicationRecord
  after_commit :broad_cast_new_message_to_channel, on: :create
  belongs_to :channel
  belongs_to :employee
  validates :content, presence: true

  private

  def broad_cast_new_message_to_channel
    channel.employees.where.not(id: employee_id).each do |employee|
      broadcast_after_to(
        "channel_#{channel_id}_messages_employee_#{employee.id}",
        partial: 'messages/message', locals: { message: self, sent: false },
        target: 'new_message'
      )
    end
  end
end
