require_relative '../../lib/figures/base'
require_relative '../../lib/figures/line'
require_relative '../../lib/canvas/point'

describe ConsoleDraw::Figures::Line do
  it 'inherits the base figure' do
    expect(described_class).to be < ConsoleDraw::Figures::Base
  end

  describe '#calculate_points!' do
    context 'when first and last points are the same' do
      let(:x) { rand 50 }
      let(:y) { rand 50 }

      subject { described_class.new(x, y, x, y).calculate_points! }

      it 'returns array with a single point' do
        expect(subject).to eq [ConsoleDraw::Canvas::Point.new(x, y)]
      end
    end

    context 'when horizontal line' do
      let(:x1) { rand 50 }
      let(:x2) { rand 50 }

      let(:y) { rand 50 }

      subject { described_class.new(x1, y, x2, y).calculate_points! }

      it 'every point has the same Y coordinate' do
        expect(subject.map(&:y)).to all be_eql y
      end

      it 'X-coordinates are between x1 and x2' do
        expect(subject.map(&:x)).to match_array ([x1, x2].min..[x1, x2].max).to_a
      end
    end

    context 'when vertical line' do
      let(:x) { rand 50 }

      let(:y1) { rand 50 }
      let(:y2) { rand 50 }

      subject { described_class.new(x, y1, x, y2).calculate_points! }

      it 'Y-coordinates are between y1 and y2' do
        expect(subject.map(&:y)).to match_array ([y1, y2].min..[y1, y2].max).to_a
      end

      it 'every point has the same X value' do
        expect(subject.map(&:x)).to all be_eql x
      end
    end

    context 'when steep line' do
      subject { described_class.new(1, 1, 2, 4).calculate_points! }

      it 'returns an array of points' do
        expect(subject.map { |point| [point.x, point.y] }).to eq [[1, 1], [1, 2], [2, 3], [2, 4]]
      end
    end
  end
end
