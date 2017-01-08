describe ConsoleDraw::Figures::Base do
  describe '#calculate_points' do
    it 'raises NotImplemented Error' do
      expect { subject.calculate_points }.to raise_exception NotImplementedError
    end
  end
end
