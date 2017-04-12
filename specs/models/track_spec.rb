require_relative '../../app/models/track'
require_relative '../../app/models/break'

describe Track do
  describe '#new' do
    it 'should create track with morning session, break and afternoon session' do
      morning_session = double('Session')
      afternoon_session = double('Session')
      _break = double('Break')
      _9_am = Time.at(12600)
      _1_pm = Time.at(27000)


      expect(Session).to receive(:new).with(_9_am, 180).and_return(morning_session)
      expect(Session).to receive(:new).with(_1_pm, 240).and_return(afternoon_session)
      expect(Break).to receive(:new).and_return(_break)

      track = Track.new

      expect(track.sessions).to eq([morning_session, _break, afternoon_session])
    end
  end
end
