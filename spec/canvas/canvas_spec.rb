describe ConsoleDraw::Canvas::Canvas do
  let(:width) { 4 }
  let(:height) { 5 }

  subject { described_class.new(width, height) }

  describe '#initizalize' do
    context 'when creates map' do
      let(:raster_map) { subject.raster_map }

      it 'sets height of a raster_map' do
        expect(raster_map.count).to eq height
      end

      it 'sets width of a raster_map' do
        raster_map.each do |row|
          expect(row.count).to eq width
        end
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
      before { subject.draw }

      it 'does not change the raster_map' do
        expect(subject.raster_map).to eq described_class.new(width, height).raster_map
      end
    end

    context 'when draw a dumb figure' do
      let(:point1) { ConsoleDraw::Canvas::Point.new(1, 2) }
      let(:point2) { ConsoleDraw::Canvas::Point.new(3, 2) }
      let(:figure) { double 'DumbFigure', calculate_points: [point1, point2] }

      before { subject.draw figure }

      it 'puts points to a raster_map' do
        expect(subject.raster_map[2][1]).to eq point1
        expect(subject.raster_map[2][3]).to eq point2
      end

      it 'does not touch other placeholders' do
        expect(subject.raster_map[1][0]).to be_nil
      end
    end

    context 'when draw invalid figure' do
      shared_examples_for 'raises InvalidCoordinatesError' do
        it { expect { subject.draw figure }.to raise_exception ConsoleDraw::Canvas::InvalidCoordinatesError }

        it 'does not mutate raster_map' do
          old_map = subject.raster_map

          begin
            subject.draw figure
          rescue ConsoleDraw::Canvas::InvalidCoordinatesError
            expect(old_map).to eq subject.raster_map
          end
        end
      end

      context 'when figure is bigger than Canvas' do
        let(:point) { ConsoleDraw::Canvas::Point.new(1, 200) }
        let(:figure) { double 'DumbFigure', calculate_points: [point] }

        it_behaves_like 'raises InvalidCoordinatesError'
      end

      context 'when figure has negative coordinates' do
        let(:point) { ConsoleDraw::Canvas::Point.new(-1, 2) }
        let(:figure) { double 'DumbFigure', calculate_points: [point] }

        it_behaves_like 'raises InvalidCoordinatesError'
      end
    end
  end

  describe '#fill' do
    it 'returns self' do
      expect(subject.fill(1, 2, 'o')).to eq subject
    end

    context 'when canvas is empty' do
      before { subject.fill(1, 2, 'o') }

      it 'fills all empty canvas' do
        expect(subject.raster_map.flatten.map &:color).to all eq 'o'
      end
    end

    context 'when canvas has an area' do
      before do
        subject.draw(ConsoleDraw::Figures::Line.new(0, 3, 3, 3))
        subject.fill(1, 2, 'o')
      end

      it 'fills only area of point' do
        expect(subject.raster_map[0].map &:color).to all eq 'o'
        expect(subject.raster_map[1].map &:color).to all eq 'o'
        expect(subject.raster_map[2].map &:color).to all eq 'o'
        expect(subject.raster_map[3].map &:color).to all eq nil # Line
        expect(subject.raster_map[4]).to all eq nil
      end
    end

    context 'when point is already drawn' do
      before do
        subject.draw(ConsoleDraw::Figures::Line.new(0, 3, 3, 3))
        subject.fill(3, 3, 'o')
      end

      it 'does nothing' do
        expect(subject.raster_map[0]).to all eq nil
        expect(subject.raster_map[1]).to all eq nil
        expect(subject.raster_map[2]).to all eq nil
        expect(subject.raster_map[3].map &:color).to all eq nil # Line
        expect(subject.raster_map[4]).to all eq nil
      end
    end
  end
end
