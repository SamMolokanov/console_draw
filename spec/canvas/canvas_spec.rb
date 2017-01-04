require_relative '../../lib/canvas/canvas'
require_relative '../../lib/canvas/point'

describe ConsoleDraw::Canvas::Canvas do
  let(:width) { 4 }
  let(:height) { 5 }

  subject { described_class.new(width, height) }

  describe '#initizalize' do
    context 'when creates map' do
      let(:map) { subject.map }

      it 'sets height of a map' do
        expect(map.count).to eq height
      end

      it 'sets width of a map' do
        map.each do |row|
          expect(row.count).to eq width
        end
      end
    end
  end

  describe '#draw' do
    context 'when draw nothing' do
      before { subject.draw }

      it 'does not change the map' do
        expect(subject.map).to eq described_class.new(width, height).map
      end
    end

    context 'when draw a dumb figure' do
      let(:point1) { ConsoleDraw::Canvas::Point.new(1, 2) }
      let(:point2) { ConsoleDraw::Canvas::Point.new(3, 2) }
      let(:figure) { double 'DumbFigure', calculate_points!: [point1, point2] }

      before { subject.draw figure }

      it 'puts points to a map' do
        expect(subject.map[2][1]).to eq point1
        expect(subject.map[2][3]).to eq point2
      end

      it 'does not touch other placeholders' do
        expect(subject.map[1][0]).to be_nil
      end
    end
  end
end
