# frozen_string_literal: true

class Events::CreateGroups < Actor
  input :groups
  output :groups
  def call
    event = groups.first.first.event
    groups.each do |array_of_participations|
      group = event.groups.create
      group.participations << array_of_participations
    end
    event.update!(groups_done: true)
  end
end
