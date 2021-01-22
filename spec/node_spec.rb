# frozen_string_literal: true

RSpec.describe LabyrinthSolver::Node do
  context 'when created' do
    it 'raises error if not given enough paths' do
      expect { described_class.new({}) }.to raise_error LabyrinthSolver::MissingPathsError
    end

    it 'creates node given enough paths' do
      expect(described_class.new(up: false, right: true, down: true, left: false)).to be_an_instance_of LabyrinthSolver::Node
    end

    it 'Accepts optional cheese parameter' do
      expect(described_class.new(up: false, right: true, down: true, left: false, cheese: true)).to be_an_instance_of LabyrinthSolver::Node  
    end
  end

  context 'when querying for directions' do
    it 'reveals if direction is open' do
      expect(described_class.new(up: false, right: true, down: true, left: false).open?(:right)).to eq(true)
    end

    it 'reveals if direction is closed' do
      expect(described_class.new(up: false, right: true, down: true, left: false).open?(:left)).to eq(false)
    end
  end

  it "tells if has cheese" do
    expect(described_class.new(up: false, right: true, down: true, left: false, cheese: true).cheese?).to eq(true)
  end

  it "closes direction" do
    node = described_class.new(up: false, right: true, down: true, left: false)
    node.close(:right)
    expect(node.open?(:right)).to eq(false)
  end
end
