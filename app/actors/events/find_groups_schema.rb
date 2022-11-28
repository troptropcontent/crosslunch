# frozen_string_literal: true

class Events::FindGroupsSchema < Actor
  input :group_size
  input :population_size
  output :schema
  def call
    self.schema = []
    return schema << population_size if group_size >= population_size

    spread_evenly
  end

  private

  def spread_evenly
    entire_chunks_number, leftovers = population_size.divmod(group_size)
    number_of_chunks = leftovers.zero? ? entire_chunks_number : entire_chunks_number + 1
    minimum_chunks_size, leftovers = population_size.divmod(number_of_chunks)
    number_of_chunks.times do |i|
      chunk_size = i < leftovers ? minimum_chunks_size + 1 : minimum_chunks_size
      schema << chunk_size
    end
  end
end
