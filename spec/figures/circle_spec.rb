describe ConsoleDraw::Figures::Circle do
  it 'inherits the base figure' do
    expect(described_class).to be < ConsoleDraw::Figures::Base
  end

  describe '#calculate_coordinates' do
    subject { described_class.new(x, y, r).calculate_coordinates }

    context 'when radius is zero' do
      let(:x) { rand 5 }
      let(:y) { rand 5 }
      let(:r) { 0 }

      it 'returns array with a single point' do
        expect(subject).to eq [[x, y]]
      end
    end

    context 'when normal circle' do
      let(:x) { 5 }
      let(:y) { 5 }
      let(:r) { 1 }

      it 'returns an array of points' do
        expect(subject).to eq [[5, 6], [5, 4], [6, 5], [4, 5]]
      end
    end
  end
end
