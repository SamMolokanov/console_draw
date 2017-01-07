describe ConsoleDraw::CLI::CLI do

  subject { described_class.new }

  describe '#run' do
    context 'when valid command' do
      let(:fake_parser) { double 'ConsoleDraw::CLI::CommandParser', parse: :foo }
      let(:fake_context) { double 'Context', execute: 'I am image!' }

      before do
        allow(ConsoleDraw::CLI::CommandParser).to receive(:new).and_return(fake_parser)
        allow(ConsoleDraw::CLI::Context).to receive(:new).and_return(fake_context)

        allow(subject).to receive(:loop).and_yield
        allow($stdin).to receive(:gets).and_return(user_input)
      end

      let(:user_input) { 'L 1 2 3 4' }

      it 'returns rendering result to output' do
        expect {
          subject.run
        }.to output(/.*I am image!.*/).to_stdout
      end

      it 'writes welcome message to output' do
        expect {
          subject.run
        }.to output(/.*#{described_class::WELCOME_MESSAGE}.*/).to_stdout
      end

      it 'send user input to parser' do
        subject.run
        expect(fake_parser).to have_received(:parse).with(user_input)
      end

      it 'executes parsed command in the context' do
        subject.run
        expect(fake_context).to have_received(:execute).with(:foo)
      end
    end

    context 'when quit command' do
      before { allow($stdin).to receive(:gets).and_return(user_input) }

      let(:user_input) { 'Q' }

      it 'exits the app' do
        expect {
          subject.run
        }.to raise_exception SystemExit
      end
    end
  end
end
