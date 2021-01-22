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

      return dead_end if circled?

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

    def circled?
      return false if path.size < 4

      idx = path.size - 1
      control_point = Point.new(position.x, position.y)

      loop do
        case path[idx]
        when :up
          control_point.y += 1
        when :down
          control_point.y -= 1
        when :left
          control_point.x += 1
        when :right
          control_point.x -= 1
        end
        return true if control_point == position

        return false if idx.zero?

        idx -= 1
      end
    end
  end
end
