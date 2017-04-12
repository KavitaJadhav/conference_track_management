require_relative '../../app/models/conference'

describe Conference do
  describe '#new' do
    it 'should create conference with given tracks' do
      conference = Conference.new(2)
      expect(conference.count).to eq(2)
    end
  end

  describe '#schedule' do
    it 'it should schedule talks for the conference' do

    end
  end
end
