# frozen_string_literal: true

require '../lib/subparry_labyrinth_solver/labyrinth'
require '../lib/subparry_labyrinth_solver/exceptions'

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
RSpec.describe Labyrinth do
  let(:lab) { described_class.new(data) }

  context 'when initializing' do
    context 'with correct data' do
      it 'creates an instance' do
        expect(lab).to be_an_instance_of described_class
      end

      it 'knows its height' do
        expect(lab.height).to eq(2)
      end

      it 'knows its width' do
        expect(lab.width).to eq(2)
      end

      it 'starts at top left corner' do
        expect(lab.position).to have_attributes(x: 0, y: 0)
      end
    end

    context 'with incorrect data' do
      it 'raises error if data is not of correct type or shape' do
        expect { described_class.new([1, 2, 3]) }.to raise_error(ArgumentError)
      end

      it 'raises error if there is no cheese' do
        expect { described_class.new([[
          { up: false, right: false, left: false, down: true },
          { up: false, right: false, left: false, down: true },
        ],
        [
          { up: true, down: false, right: true, left: false },
          { up: true, down: false, right: false, left: true }
        ]]) }.to raise_error MissingCheeseError
      end
    end
  end

  context 'when moving' do
    it 'updates its position' do
      lab.go(:down)
      expect(lab.position).to have_attributes(x: 0, y: 1)

      lab.go(:right)
      expect(lab.position).to have_attributes(x: 1, y: 1)

      lab.go(:left)
      expect(lab.position).to have_attributes(x: 0, y: 1)

      lab.go(:up)
      expect(lab.position).to have_attributes(x: 0, y: 0)
    end

    it 'disallows moving through walls' do
      expect { lab.go(:left) }.to raise_error InvalidMoveError
    end

    it 'raises error if attempting to move to non existent direction' do
      expect { lab.go(:diagonal) }.to raise_error InvalidMoveError
    end
  end
end
