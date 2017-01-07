describe ConsoleDraw::CLI::Context do

  subject { described_class.new(renderer) }

  describe '#execute' do
    before { subject.execute proc { canvas } }

    let(:renderer) { class_double 'Renderer', render: 'hello!' }
    let(:canvas) { double 'Canvas', raster_map: [] }
    let(:command) { proc { |canvas| canvas.draw(:foo) } }

    context 'when execute command' do
      before { allow(canvas).to receive(:draw).and_return(canvas) }

      it 'calls command on the canvas' do
        subject.execute command
        expect(canvas).to have_received(:draw).with :foo
      end

      it 'returns result of rendering' do
        expect(subject.execute command).to eq renderer.render
      end
    end
  end
end
