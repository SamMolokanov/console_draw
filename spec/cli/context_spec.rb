describe ConsoleDraw::CLI::Context do
  subject { described_class.new }

  let(:fake_canvas) do
    double 'Canvas', clean!: :asd, draw: :foo, fill: :bar, points: []
  end

  before do
    allow(ConsoleDraw::Canvas::Canvas).to receive(:new).and_return fake_canvas
    allow(ConsoleDraw::Figures::Line).to receive(:new).and_return :foo
    allow(ConsoleDraw::Figures::Rectangle).to receive(:new).and_return :bar
    allow(ConsoleDraw::Figures::Circle).to receive(:new).and_return :circle
    allow(ConsoleDraw::Render::StringRenderer).to receive :render
  end

  shared_examples_for 'renders canvas' do
    it { expect(ConsoleDraw::Render::StringRenderer).to have_received(:render).with(fake_canvas) }
  end

  describe '#new_canvas' do
    before { subject.new_canvas(10, 10) }

    it 'creates new Canvas with arguments' do
      expect(ConsoleDraw::Canvas::Canvas).to have_received(:new).with(10, 10)
    end

    it_behaves_like 'renders canvas'
  end

  describe '#clean_canvas' do
    context 'when canvas exists' do
      before do
        subject.new_canvas(10, 10)
        subject.clean_canvas
      end

      it 'calls clean! on canvas' do
        expect(fake_canvas).to have_received(:clean!)
      end
    end

    context 'canvas does not exist' do
      it 'return NO_CANVAS_MESSAGE' do
        expect(subject.clean_canvas).to eq described_class::NO_CANVAS_EXISTS
      end
    end
  end

  describe '#draw_line' do
    before do
      subject.instance_variable_set :@canvas, fake_canvas
      subject.draw_line(1, 1, 15, 15)
    end

    it 'creates new Line with arguments' do
      expect(ConsoleDraw::Figures::Line).to have_received(:new).with(0, 0, 14, 14)
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
      expect(ConsoleDraw::Figures::Rectangle).to have_received(:new).with(1, 1, 9, 9)
    end

    it 'calls #draw on canvas with arguments' do
      expect(fake_canvas).to have_received(:draw).with :bar
    end

    it_behaves_like 'renders canvas'
  end

  describe '#draw_circle' do
    before do
      subject.instance_variable_set :@canvas, fake_canvas
      subject.draw_circle(5, 5, 4)
    end

    it 'creates new Rectangle with arguments' do
      expect(ConsoleDraw::Figures::Circle).to have_received(:new).with(4, 4, 4)
    end

    it 'calls #draw on canvas with arguments' do
      expect(fake_canvas).to have_received(:draw).with :circle
    end

    it_behaves_like 'renders canvas'
  end

  describe '#fill' do
    before do
      subject.instance_variable_set :@canvas, fake_canvas
      subject.fill(1, 1, 'a')
    end

    it 'calls #fill on canvas with arguments' do
      expect(fake_canvas).to have_received(:fill).with(0, 0, 'a')
    end

    it_behaves_like 'renders canvas'
  end
end
