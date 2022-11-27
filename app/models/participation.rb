class Participation < ApplicationRecord
  after_commit :broad_cast_new_participations_count, on: %i[create destroy]
  belongs_to :employee
  belongs_to :event

  private

  def broad_cast_new_participations_count
    broadcast_replace_to(
      "participations_count_event_#{event_id}",
      partial: 'participations/count', locals: { count: event.participations.count, event: event },
      target: "participations_count_event_#{event_id}"
    )
  end
end
