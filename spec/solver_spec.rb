# frozen_string_literal: true

require_relative '../lib/subparry_labyrinth_solver/solver'

data = [
  [
    { up: false, right: false, left: false, down: true },
    { up: false, right: false, left: false, down: true, cheese: true },
  ],
  [
    { up: true, down: false, right: true, left: false },
    { up: true, down: false, right: false, left: true }
  ]
]

bifurcated_data = [
  [
    { up: false, right: true, left: false, down: true },
    { up: false, right: true, left: true, down: false },
    { up: false, right: false, left: true, down: true }
  ],
  [
    { up: true, right: false, left: false, down: true },
    { up: false, right: false, left: false, down: true, cheese: true },
    { up: true, right: false, left: false, down: false }
  ],
  [
    { up: true, right: true, left: false, down: false },
    { up: true, right: true, left: true, down: false },
    { up: false, right: false, left: true, down: false }
  ],
]

RSpec.describe Solver do
  let(:solver) { described_class.new(Labyrinth.new(data)) }
  let(:bifurcated) { described_class.new(Labyrinth.new(bifurcated_data)) }

  context 'when initializing' do
    it 'receives a labyrinth instance as argument' do
      expect(solver).to be_an_instance_of described_class
    end

    it 'raises error if not given proper argument' do
      expect {described_class.new('hello')}.to raise_error ArgumentError
    end
  end

  context 'when solving' do
    it 'reveals current position' do
      expect(solver.position).to have_attributes(x: 0, y: 0)
    end

    it 'moves to next open node' do
      solver.go_next
      expect(solver.position).to have_attributes(x: 0, y: 1)
    end

    it "does not turn back if there's still open paths ahead" do
      solver.go_next
      solver.go_next
      expect(solver.position).to have_attributes(x: 1, y: 1)
    end

    it "knows if there's cheese in current node" do
      solver.go_next
      expect(solver.cheese?).to eq(false)
      solver.go_next
      solver.go_next
      expect(solver.cheese?).to eq(true)
    end

    it 'finds cheese' do
      solver.solve
      expect(solver.cheese?).to eq(true)
      expect(solver.position).to have_attributes(x: 1, y: 0)
    end

    it 'returns correct path after finding cheese' do
      solver.solve
      expect(solver.path).to eq([:down, :right, :up])
    end

    it 'solves labyrinth with bifurcations' do
      bifurcated.solve
      expect(bifurcated.cheese?).to eq(true)
    end

    it 'delivers right path for bifurcated labyrinth' do
      bifurcated.solve
      expect(bifurcated.path).to eq(%i[down down right up])
    end
  end
end