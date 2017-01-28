describe ConsoleDraw::Figures::Base do
  describe '#calculate_coordinates' do
    it 'raises NotImplemented Error' do
      expect { subject.calculate_coordinates }.to raise_exception NotImplementedError
    end
  end
end
