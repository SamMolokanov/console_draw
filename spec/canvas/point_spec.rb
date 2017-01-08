describe ConsoleDraw::Canvas::Point do
  let(:x) { rand }
  let(:y) { rand }
  let(:color) { 'a' }

  subject { described_class.new x, y, color }

  it 'has X coordinate' do
    expect(subject.x).to eq x
  end

  it 'has Y coordinate' do
    expect(subject.y).to eq y
  end

  it 'has color attribute' do
    expect(subject.color).to eq color
  end
end
