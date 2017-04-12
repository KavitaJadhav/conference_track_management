require_relative '../../app/models/break'

describe Break do
  describe '#new' do
    it 'should create new break with start_time and type' do
      _break = Break.new()
      expect(_break.start_time.strftime('%H%M%S')).to eq('120000')
      expect(_break.type).to eq('Lunch')
    end
  end
end
