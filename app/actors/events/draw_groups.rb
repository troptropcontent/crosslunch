# frozen_string_literal: true

module Events
  class DrawGroups < Actor
    input :event
    output :groups
    play ->(actor) { actor.population_size ||= actor.event.participations.count },
         ->(actor) { actor.group_size ||= actor.event.recurring_event.group_size },
         FindGroupsSchema,
         SplitParticipantsInRandomGroups,
         CreateGroups
  end
end
