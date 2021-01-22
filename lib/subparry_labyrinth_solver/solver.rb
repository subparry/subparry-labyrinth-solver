# frozen_string_literal: true

require 'forwardable'
module LabyrinthSolver
  # Takes a labyrinth and attempts to solve it saving the path taken
  class Solver
    attr_reader :path

    extend Forwardable

    OPPOSITE_DIRECTIONS = { up: :down, right: :left, down: :up, left: :right }.freeze

    def_delegators :@labyrinth, :position, :cheese?, :go, :close

    def initialize labyrinth
      raise ArgumentError unless labyrinth.instance_of? Labyrinth

      @labyrinth = labyrinth
      @path = []
    end

    def go_next
      next_dir = OPPOSITE_DIRECTIONS.find { |dir, opp| @labyrinth.open?(dir) && opp != @path.last }
      return dead_end unless next_dir

      go(next_dir.first)
      @path.push(next_dir.first)
    end

    def solve
      go_next until cheese?
    end

    private
    
    def dead_end
      to_close = path.pop
      go(OPPOSITE_DIRECTIONS[to_close])
      close(to_close)
    end
  end
end