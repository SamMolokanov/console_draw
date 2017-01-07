describe ConsoleDraw::CLI::Context do
  subject { described_class.new }

  let(:fake_canvas) { double 'Canvas', draw: :foo, raster_map: [] }

  before do
    allow(ConsoleDraw::Canvas::Canvas).to receive(:new).and_return fake_canvas
    allow(ConsoleDraw::Figures::Line).to receive(:new).and_return :foo
    allow(ConsoleDraw::Figures::Rectangle).to receive(:new).and_return :bar
    allow(ConsoleDraw::Render::StringRenderer).to receive :render
  end

  shared_examples_for 'renders canvas' do
    it { expect(ConsoleDraw::Render::StringRenderer).to have_received(:render).with(fake_canvas.raster_map) }
  end

  describe '#new_canvas' do
    before { subject.new_canvas(10, 10) }

    it 'creates new Canvas with arguments' do
      expect(ConsoleDraw::Canvas::Canvas).to have_received(:new).with(10, 10)
    end

    it_behaves_like 'renders canvas'
  end

  describe '#draw_line' do
    before do
      subject.instance_variable_set :@canvas, fake_canvas
      subject.draw_line(1, 1, 15, 15)
    end

    it 'creates new Line with arguments' do
      expect(ConsoleDraw::Figures::Line).to have_received(:new).with(1, 1, 15, 15)
    end

    it 'calls #draw on canvas with arguments' do
      expect(fake_canvas).to have_received(:draw).with :foo
    end

    it_behaves_like 'renders canvas'
  end

  describe '#draw_rectangle' do
    before do
      subject.instance_variable_set :@canvas, fake_canvas
      subject.draw_rectangle(2, 2, 10, 10)
    end

    it 'creates new Rectangle with arguments' do
      expect(ConsoleDraw::Figures::Rectangle).to have_received(:new).with(2, 2, 10, 10)
    end

    it 'calls #draw on canvas with arguments' do
      expect(fake_canvas).to have_received(:draw).with :bar
    end

    it_behaves_like 'renders canvas'
  end
end
