require_relative '../../app/models/session'
require_relative '../../app/utils/time_util'

describe Session do
  let(:start_time) { Time.at(12600) }
  let(:session) { Session.new(start_time, 100) }

  describe '#new' do
    it 'should create a session with duration,time available and start_time' do
      expect(session.start_time).to eq(start_time)
      expect(session.duration).to eq(100)
    end
  end

  describe '#talks' do
    it 'should return list of talks when talks added' do
      session.talks << 'talk1'
      session.talks << 'talk2'
      expect(session.talks).to match_array(['talk1', 'talk2'])
    end

    it 'should return empty array when talks are not added in the session' do
      expect(session.talks).to eq([])
    end
  end

  describe '#add_talk' do
    it 'should add talk in the session' do
      talk = double('Talk', duration: 20)
      expect(talk).to receive(:start_time=).with(start_time)
      expect(talk).to receive(:scheduled=).with(true)

      session.add_talk(talk)

      expect(session.time_available).to eq(80)
    end
  end
end
