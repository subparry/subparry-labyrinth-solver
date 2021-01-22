# subparry_labyrinth_solver

[![codecov](https://codecov.io/gh/subparry/subparry-labyrinth-solver/branch/master/graph/badge.svg?token=AHG1N8FZA0)](https://codecov.io/gh/subparry/subparry-labyrinth-solver)
[![Build Status](https://travis-ci.com/subparry/subparry-labyrinth-solver.svg?branch=master)](https://travis-ci.com/subparry/subparry-labyrinth-solver)
[![Gem Version](https://badge.fury.io/rb/subparry_labyrinth_solver.svg)](https://badge.fury.io/rb/subparry_labyrinth_solver)

## Description

Fun little project about labyrinth solving inspired in mice that find cheese in a maze.

It exposes some classes to create a labyrinth and then find the path to the cheese.

Be advised: **It does not support labyrinths with circular paths and if you try to solve one of these, it will result in an infinite loop**.

That being said, I plan to support that kind of labyrinths soon.

## Usage

```
gem install subparry_labyrinth_solver
```

```ruby
require 'subparry_labyrinth_solver'

# First define labyrinth data as a 2 dimensional array where
# each square is represented by a hash with :up, :down, :left and :right
# as keys and an optional key :cheese representing the "goal" square.
# A value of true for a direction represents an open path, and false
# represents a wall.

data = [
  [ # The first row
    { up: false, right: false, left: false, down: true },
    { up: false, right: false, left: false, down: true, cheese: true },
  ],
  [ # The second row
    { up: true, down: false, right: true, left: false },
    { up: true, down: false, right: false, left: true }
  ]
]

# This data represents this maze:
#      ___ ___
#     |   | 🧀|
#     |   |   |
#     |       |
#     |_______|

# Then initialize the labyrinth:
lab = LabyrinthSolver::Labyrinth.new(data)

# Then initialize the solver:
solver = LabyrinthSolver::Solver.new(lab)

# And call solve on the instance. This call will trigger
# the cheese-finding loop and record the right path.
solver.solve

# Confirm that cheese was found:
solver.cheese? # => true

# Retrieve the path:
solver.path # => [:down, :right, :up]

# Get the coordinates of the cheese:
solver.position # => <struct x: 1, y: 0>

# Note that the coordinates are like image coordinates where top-left
# corner is x: 0, y: 0 and bottom-right is x: width, y: length
```

## Pending

- Support labyrinths with circular paths
- Create a labyrinth maker class
- Visual representation of labyrinths
