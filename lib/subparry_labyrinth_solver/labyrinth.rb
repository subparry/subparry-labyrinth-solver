# frozen_string_literal: true

require 'forwardable'

module LabyrinthSolver
  Point = Struct.new(:x, :y)
  # Labyrinth class in charge of keeping track of all nodes and performing movements
  class Labyrinth
    attr_reader :height, :width, :position

    extend Forwardable

    def_delegators :current_node, :open?, :cheese?, :close

    def self.validate_data data 
      raise ArgumentError unless data.respond_to?(:each) && data.first.respond_to?(:each)
      raise MissingCheeseError unless data.any? { |rows| rows.any? {|paths| paths[:cheese]} }
    end

    def initialize(data)
      Labyrinth.validate_data data

      @height = data.size
      @width = data.first.size
      @position = Point.new(0, 0)
      @nodes = data.collect { |row| row.collect { |cell| Node.new(cell) } }
    end

    def go direction
      raise InvalidMoveError, "Attempted to move #{direction}" unless open? direction

      case direction
      when :up
        @position.y -= 1
      when :down
        @position.y += 1
      when :left
        @position.x -= 1
      when :right
        @position.x += 1
      end
    end

    private

    def current_node
      @nodes[@position.y][@position.x]
    end
  end
end