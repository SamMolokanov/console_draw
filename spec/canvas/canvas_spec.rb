describe ConsoleDraw::Canvas::Canvas do
  let(:width) { 4 }
  let(:height) { 5 }

  subject { described_class.new(width, height) }

  describe '#initizalize' do
    context 'when creates map' do
      let(:points) { subject.points }

      it 'sets lengs of points height * width' do
        expect(points.count).to eq height * width
      end
    end

    context 'invalid width or height' do
      it 'raises an error for negative width' do
        expect { described_class.new(-1, 2) }.to raise_exception ConsoleDraw::Canvas::InvalidCanvasSizeError
      end

      it 'raises an error for negative height' do
        expect { described_class.new(1, -2) }.to raise_exception ConsoleDraw::Canvas::InvalidCanvasSizeError
      end

      it 'raises an error for zero value' do
        expect { described_class.new(1, 0) }.to raise_exception ConsoleDraw::Canvas::InvalidCanvasSizeError
      end
    end
  end

  describe '#draw' do
    it 'returns self' do
      expect(subject.draw).to eq subject
    end

    context 'when draw nothing' do
      it 'does not change points' do
        expect { subject.draw }.not_to change { subject.points }
      end
    end

    context 'when draw a dumb figure' do
      let(:point1) { ConsoleDraw::Canvas::Point.new(1, 2) }
      let(:point2) { ConsoleDraw::Canvas::Point.new(3, 2) }
      let(:figure) { double 'DumbFigure', calculate_coordinates: [[1, 2], [3, 2]] }

      before { subject.draw figure }

      it 'puts points' do
        expect(subject.get_point(1, 2)).to eq point1
        expect(subject.get_point(3, 2)).to eq point2
      end

      it 'does not touch other placeholders' do
        expect(subject.get_point(1, 0)).to be_nil
      end
    end

    context 'when draw invalid figure' do
      shared_examples_for 'raises InvalidCoordinatesError' do
        it { expect { subject.draw figure }.to raise_exception ConsoleDraw::Canvas::InvalidCoordinatesError }

        it 'does not mutate points' do
          old_points = subject.points

          begin
            subject.draw figure
          rescue ConsoleDraw::Canvas::InvalidCoordinatesError
            expect(old_points).to eq subject.points
          end
        end
      end

      context 'when figure is bigger than Canvas' do
        let(:figure) { double 'DumbFigure', calculate_coordinates: [[1, 200]] }

        it_behaves_like 'raises InvalidCoordinatesError'
      end

      context 'when figure has negative coordinates' do
        let(:figure) { double 'DumbFigure', calculate_coordinates: [[-1, 2]] }

        it_behaves_like 'raises InvalidCoordinatesError'
      end
    end
  end

  describe '#fill' do
    let(:figure) { ConsoleDraw::Figures::Line.new(0, 3, 3, 3) }

    it 'returns self' do
      expect(subject.fill(1, 2, 'o')).to eq subject
    end

    context 'when canvas is empty' do
      before { subject.fill(1, 2, 'o') }

      it 'fills all empty canvas' do
        expect(subject.points.map &:color).to all eq 'o'
      end
    end

    context 'when canvas has an area' do
      before do
        subject.draw figure
        subject.fill(1, 2, 'o')
      end

      it 'does not change color of a line' do
        figure.calculate_coordinates.each do |x, y|
          expect(subject.get_point(x, y).color).to eq nil
        end
      end

      it 'fills area above the line' do
        expect(subject.points[0..2 * width + 3].map &:color).to all eq 'o'
      end

      it 'fills only area around of the point' do
        expect(subject.points[4 * width..-1]).to all eq nil
      end
    end

    context 'when point is already drawn' do
      before do
        subject.draw figure
        subject.fill(3, 3, 'o')
      end

      it 'does not change color of a line' do
        figure.calculate_coordinates.each do |x, y|
          expect(subject.get_point(x, y).color).to eq nil
        end
      end

      it 'does nothing with other areas' do
        expect(subject.points[0..2 * width + 3]).to all be_nil
        expect(subject.points[4 * width..-1]).to all be_nil
      end
    end
  end

  describe '#clean!' do
    before do
      subject.draw(ConsoleDraw::Figures::Line.new(0, 3, 3, 3))
      subject.clean!
    end

    it 'cleans points array' do
      expect(subject.points).to all be_nil
    end

    it 'does not change a width' do
      expect(subject.width).to eq width
    end

    it 'does not change a height' do
      expect(subject.height).to eq height
    end
  end

  describe '#set_point, #get_point' do
    DumbPoint = Struct.new(:x, :y, :payload)

    let(:point) { DumbPoint.new 2, 3, :foo }

    context 'when point already set' do
      before { subject.set_point point }

      it 'returns previously set point' do
        expect(subject.get_point(2, 3)).to eq point
      end
    end

    context 'when point not set' do
      it 'returns nil' do
        expect(subject.get_point(2, 3)).to be_nil
      end
    end
  end
end
