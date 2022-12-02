class Message < ApplicationRecord
  include ActionView::RecordIdentifier
  after_commit :broad_cast_new_message_to_channel, on: :create
  belongs_to :channel
  belongs_to :employee
  validates :content, presence: true

  private

  def broad_cast_new_message_to_channel
    broadcast_after_to(
      dom_id(channel),
      partial: 'messages/message', locals: { message: self, sent: false },
      target: 'new_message'
    )
  end
end
