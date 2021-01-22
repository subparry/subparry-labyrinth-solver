require 'subparry_labyrinth_solver/node'
require 'subparry_labyrinth_solver/labyrinth'
require 'subparry_labyrinth_solver/solver'
module LabyrinthSolver
  class MissingPathsError < ArgumentError; end
  class InvalidMoveError < RuntimeError; end
  class MissingCheeseError < ArgumentError; end
end