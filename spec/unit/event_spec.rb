RSpec.describe Ma::Event do
  describe '#initialize' do
    it 'sets attributes' do
      subject = described_class.new(name: 'Kris')
      expect(subject.name).to eq('Kris')
    end
  end

  describe '#to_h' do
    it 'returns attributes' do
      attrs = { name: 'Kris' }
      subject = described_class.new(attrs)
      expect(subject.to_h).to eq(attrs)
    end
  end

  it 'is frozen' do
    expect(described_class.new).to be_frozen
  end
end
