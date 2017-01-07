describe ConsoleDraw::CLI::CLI do

  subject { described_class.new }

  describe '#run' do
    context 'when valid command' do
      let(:fake_executor) { double 'ConsoleDraw::CLI::CommandExecutor', execute: 'I am image!' }

      before do
        allow(ConsoleDraw::CLI::CommandExecutor).to receive(:new).and_return(fake_executor)

        allow(subject).to receive(:loop).and_yield
        allow($stdin).to receive(:gets).and_return(user_input)
      end

      let(:user_input) { 'L 1 2 3 4' }

      it 'returns result of the command to output' do
        expect {
          subject.run
        }.to output(/.*I am image!.*/).to_stdout
      end

      it 'writes welcome message to output' do
        expect {
          subject.run
        }.to output(/.*#{described_class::WELCOME_MESSAGE}.*/).to_stdout
      end

      it 'send user input to executor' do
        subject.run
        expect(fake_executor).to have_received(:execute).with(user_input)
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
