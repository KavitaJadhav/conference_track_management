require_relative '../../app/models/conference'

describe Conference do
  describe '#new' do
    it 'should create conference with given tracks' do
      conference = Conference.new(2)
      expect(conference.tracks.count).to eq(2)
    end
  end

  describe '#schedule' do
    let(:conference) { Conference.new(2) }
    let(:talks) { [double('Talk', duration: 20)] }
    let(:tracks) { conference.tracks }

    it 'it should schedule talks in the session having maximum available time' do
      morning_session1 = double('Session', time_available: 50)
      morning_session2 = double('Session', time_available: 60)

      expect(tracks[0]).to receive(:morning_session).and_return(morning_session1)
      expect(tracks[1]).to receive(:morning_session).and_return(morning_session2)

      expect(morning_session2).to receive(:add_talk).with(talks[0])
      expect(talks[0]).to receive(:scheduled).and_return(true)

      conference.schedule(talks)
    end

    it 'should schedule talk in afternoon session if morning sessions are full' do
      talk = double('Talk', duration: 70)
      networking_talk = double('Talk')

      morning_session1 = double('Session', time_available: 50)
      morning_session2 = double('Session', time_available: 60)

      afternoon_session1 = double('Session', time_available: 80)
      afternoon_session2 = double('Session', time_available: 90)

      allow(tracks[0]).to receive(:afternoon_session).and_return(afternoon_session1)
      allow(tracks[1]).to receive(:afternoon_session).and_return(afternoon_session2)
      allow(TimeUtil).to receive(:minute_back).and_return(Time.at(0))

      allow(tracks[0]).to receive(:morning_session).and_return(morning_session1)
      allow(tracks[1]).to receive(:morning_session).and_return(morning_session2)

      expect(talk).to receive(:scheduled).and_return(false)
      expect(afternoon_session2).to receive(:add_talk).with(talk)

      allow(Talk).to receive(:new).with('Networking', 60).and_return(networking_talk)
      allow(afternoon_session1).to receive(:add_talk).with(networking_talk)
      allow(afternoon_session2).to receive(:add_talk).with(networking_talk)
      allow(networking_talk).to receive(:start_time=)

      conference.schedule([talk])
    end

    it 'should schedule networking session after 4 even though time available before 4' do
      networking_talk = double('Talk')

      expect(tracks[0].afternoon_session).to receive(:time_available).and_return(100)
      expect(tracks[1].afternoon_session).to receive(:time_available).and_return(100)

      expect(Talk).to receive(:new).with('Networking', 60).and_return(networking_talk)
      expect(tracks[0].afternoon_session).to receive(:add_talk).with(networking_talk)
      expect(tracks[1].afternoon_session).to receive(:add_talk).with(networking_talk)
      expect(networking_talk).to receive(:start_time=).with(Time.at(37800))

      conference.schedule([])
    end

    it 'should schedule networking session between 4 and 5 if afternoon sessions have available time' do
      networking_talk = double('Talk')

      expect(tracks[0].afternoon_session).to receive(:time_available).and_return(45)
      expect(tracks[1].afternoon_session).to receive(:time_available).and_return(30)

      expect(Talk).to receive(:new).with('Networking', 60).and_return(networking_talk)
      expect(tracks[0].afternoon_session).to receive(:add_talk).with(networking_talk)
      expect(tracks[1].afternoon_session).to receive(:add_talk).with(networking_talk)
      expect(networking_talk).to receive(:start_time=).with(Time.at(39600))

      conference.schedule([])
    end

    it 'should schedule networking session at5 if afternoon sessions are full' do
      networking_talk = double('Talk')

      expect(tracks[0].afternoon_session).to receive(:time_available).and_return(0)
      expect(tracks[1].afternoon_session).to receive(:time_available).and_return(0)

      expect(Talk).to receive(:new).with('Networking', 60).and_return(networking_talk)
      expect(tracks[0].afternoon_session).to receive(:add_talk).with(networking_talk)
      expect(tracks[1].afternoon_session).to receive(:add_talk).with(networking_talk)
      expect(networking_talk).to receive(:start_time=).with(Time.at(41400))

      conference.schedule([])
    end
  end
end
