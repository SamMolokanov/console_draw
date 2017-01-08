describe ConsoleDraw::Render::StringRenderer do
  describe '.render' do
    subject { described_class.render(points_map) }

    context 'when empty map' do
      let(:points_map) { [[]] }

      it 'renders empty string in a frame' do
        # --
        # ||
        # --
        expect(subject).to eq "--\n||\n--"
      end
    end

    context 'when map without points' do
      let(:points_map) { [[nil], [nil]] }

      it 'renders spaces and new lines in a frame' do
        # ---
        # | |
        # | |
        # ---
        expect(subject).to eq "---\n| |\n| |\n---"
      end
    end

    context 'when map with points and holes' do
      let(:fake_point_a) { double 'Point', color: 'a' }
      let(:fake_point_b) { double 'Point', color: 'b' }

      let(:points_map) { [[nil, fake_point_a], [fake_point_b, nil]] }

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
