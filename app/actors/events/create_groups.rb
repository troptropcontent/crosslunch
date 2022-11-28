# frozen_string_literal: true

class Events::CreateGroups < Actor
  input :groups
  output :groups
  def call
    groups.each do |array_of_participations|
      event = array_of_participations.first.event
      group = event.groups.create
      group.participations << array_of_participations
    end
  end
end
