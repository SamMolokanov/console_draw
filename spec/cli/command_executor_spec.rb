describe ConsoleDraw::CLI::CommandExecutor do
  describe '#execute' do
    let(:fake_context) { double 'Context', new_canvas: :foo, draw_line: :bar, draw_rectangle: :baz }

    before do
      allow(ConsoleDraw::CLI::Context).to receive(:new).and_return fake_context
    end

    before { described_class.new.execute(user_input) }

    context 'when new Canvas command' do
      let(:user_input) { 'C 15 15' }

      it 'initializes a new canvas' do
        expect(fake_context).to have_received(:new_canvas).with(15, 15)
      end
    end

    context 'when draw Line command' do
      let(:user_input) { 'L 1 1 10 10' }

      it 'generates new line' do
        expect(fake_context).to have_received(:draw_line).with(1, 1, 10, 10)
      end

    end

    context 'when draw Rectangle command' do
      let(:user_input) { 'R 1 1 10 10' }

      it 'generates new rectangle' do
        expect(fake_context).to have_received(:draw_rectangle).with(1, 1, 10, 10)
      end
    end

    context 'when unexpected input' do
      let(:user_input) { 'foobarbaz' }

      it 'returns a message' do
        expect(described_class.new.execute(user_input)).to eq described_class::UNSUPPORTED_MESSAGE
      end
    end
  end
end
