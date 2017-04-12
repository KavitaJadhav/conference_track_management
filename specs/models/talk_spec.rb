require_relative '../../app/models/talk'

describe Talk do

  describe '#new' do
    it 'should create new talk with name and duration' do
      let(:talk) { Talk.new('My talk', 20) }

      expect(talk.title).to eq('My talk')
      expect(talk.duration).to eq(20)
    end
  end
end
