describe ConsoleDraw::CLI::CommandExecutor do
  describe '#execute' do
    let(:fake_context) do
      double 'Context',
             new_canvas: :foo,
             draw_line: :bar,
             draw_rectangle: :baz,
             fill: :bam,
             clean_canvas: :asd
    end

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

    context 'when new clean Canvas command' do
      let(:user_input) { 'C' }

      it 'asks context to clean canvas' do
        expect(fake_context).to have_received(:clean_canvas)
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

    context 'when fill area' do
      let(:user_input) { 'B 1 1 a' }

      it 'call method fill of the context' do
        expect(fake_context).to have_received(:fill).with(1, 1, 'a')
      end
    end

    context 'when incorrect input' do
      context 'when input very big numbers' do
        let(:user_input) { 'L 1 1000 10 10' }

        it 'asks for confirmation' do
          expect(described_class.new.execute(user_input)).to eq described_class::REQUIRE_CONFIRMATION_MESSAGE
        end

        context 'when confirm immideatly' do
          let(:executor) { described_class.new }

          before do
            executor.execute(user_input)
            executor.execute('Yes')
          end

          it 'runs a deferred command' do
            expect(fake_context).to have_received(:draw_line).with(1, 1000, 10, 10)
          end
        end

        context 'when not confirm immideatly and confirm later' do
          let(:executor) { described_class.new }

          before do
            executor.execute(user_input)
            executor.execute('B 1 1 a')
            executor.execute('Yes')
          end

          it 'does not run a deferred command' do
            expect(fake_context).not_to have_received(:draw_line).with(1, 1000, 10, 10)
          end
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
end
