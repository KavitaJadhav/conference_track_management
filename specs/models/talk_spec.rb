require_relative '../../app/models/talk'

describe Talk do

  describe '#new' do
    let(:talk) { Talk.new('My talk', 20) }

    it 'should create new talk with name and duration' do
      expect(talk.title).to eq('My talk')
      expect(talk.duration).to eq(20)
    end
  end
end
