describe ConsoleDraw::Canvas::Point do
  let(:x) { rand }
  let(:y) { rand }

  subject { described_class.new x, y }

  it 'has X coordinate' do
    expect(subject.x).to eq x
  end

  it 'has Y coordinate' do
    expect(subject.y).to eq y
  end
end
