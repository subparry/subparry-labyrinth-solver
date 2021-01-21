# frozen_string_literal: true

# Class to represent a single labyrinth square or node
class Node
  def initialize(paths)
    raise MissingPathsError if paths[:up].nil? || paths[:down].nil? || paths[:left].nil? || paths[:right].nil?

    @paths = paths
    @cheese = paths[:cheese] || false
  end

  def open? direction
    @paths[direction]
  end

  def cheese?
    @cheese
  end

  def close direction
    @paths[direction] = false
  end
end
