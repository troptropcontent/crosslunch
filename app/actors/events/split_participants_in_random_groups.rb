# frozen_string_literal: true

class Events::SplitParticipantsInRandomGroups < Actor
  input :event
  input :schema
  output :groups
  output :remaining_participations
  def call
    self.groups = []
    self.remaining_participations = event.participations.to_a
    schema.each do |chunk_size|
      draw_a_sample_of_participations(chunk_size)
    end
  end

  private

  def draw_a_sample_of_participations(chunk_size)
    shuffled_participations = remaining_participations.shuffle
    chunk = shuffled_participations[...chunk_size]
    self.remaining_participations = shuffled_participations[chunk_size..]
    groups << chunk
  end
end
