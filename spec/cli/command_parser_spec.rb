describe ConsoleDraw::CLI::CommandParser do
  describe '#parse' do
    let(:canvas) { double 'Canvas' }
    before { allow(canvas).to receive(:draw).and_return(canvas) }

    let(:command) { described_class.new.parse(user_input) }

    before do
      allow(ConsoleDraw::Canvas::Canvas).to receive(:new).and_return(:baz)
      allow(ConsoleDraw::Figures::Line).to receive(:new).and_return(:foo)
      allow(ConsoleDraw::Figures::Rectangle).to receive(:new).and_return(:bar)
    end

    before { command.call canvas }

    context 'when new Canvas command' do
      let(:user_input) { 'C 15 15' }

      it 'initializes a new canvas' do
        expect(ConsoleDraw::Canvas::Canvas).to have_received(:new).with(15, 15)
      end
    end

    context 'when draw Line command' do
      let(:user_input) { 'L 1 1 10 10' }

      it 'generates new line' do
        expect(ConsoleDraw::Figures::Line).to have_received(:new).with(1, 1, 10, 10)
      end

      it 'draws new line on canvas' do
        expect(canvas).to have_received(:draw).with :foo
      end
    end

    context 'when draw Rectangle command' do
      let(:user_input) { 'R 1 1 10 10' }

      it 'generates new rectangle' do
        expect(ConsoleDraw::Figures::Rectangle).to have_received(:new).with(1, 1, 10, 10)
      end

      it 'draws new rectangle on canvas' do
        expect(canvas).to have_received(:draw).with :bar
      end
    end
  end
end
