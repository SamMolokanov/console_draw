describe ConsoleDraw::Render::StringRenderer do
  describe '.render' do
    subject { described_class.render(points_map) }

    context 'when empty map' do
      let(:points_map) { [[]] }

      it 'renders empty string' do
        expect(subject).to eq ''
      end
    end

    context 'when map without points' do
      let(:points_map) { [[nil], [nil]] }

      it 'renders spaces and new lines' do
        expect(subject).to eq " \n "
      end
    end

    context 'when map with points and holes' do
      let(:fake_point_a) { double 'Point', color: 'a' }
      let(:fake_point_b) { double 'Point', color: 'b' }

      let(:points_map) { [[nil, fake_point_a], [fake_point_b, nil]] }

      it 'renders visible chars and spaces' do
        expect(subject).to eq " a\nb "
      end
    end
  end
end
