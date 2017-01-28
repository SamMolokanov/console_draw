describe ConsoleDraw::Render::StringRenderer do
  describe '.render' do
    subject { described_class.render(canvas) }
    let(:canvas) { ConsoleDraw::Canvas::Canvas.new(2, 2) }

    context 'when canvas without points' do
      it 'renders spaces and new lines in a frame' do
        # ----
        # |  |
        # |  |
        # ----
        expect(subject).to eq "----\n|  |\n|  |\n----"
      end
    end

    context 'when canvas with points and holes' do
      let(:fake_point_a) { double 'Point', x: 1, y: 0, color: 'a' }
      let(:fake_point_b) { double 'Point', x: 0, y: 1, color: 'b' }

      before do
        canvas.set_point fake_point_a
        canvas.set_point fake_point_b
      end

      it 'renders visible chars and spaces in a frame' do
        # ----
        # | a|
        # |b |
        # ----
        expect(subject).to eq "----\n| a|\n|b |\n----"
      end
    end
  end
end
