require_relative '../../app/models/manager'

describe Manager do
  describe '#create_conference' do
    it 'should create and print schedule of conference' do
      file = 'tmp/talk_list.txt'
      start_time = DateTime.parse('01/01/2015 11:10:00')

      talk1 = double('Talk', start_time: start_time, title: 'Talk1')
      talk2 = double('Talk', start_time: start_time, title: 'Talk2')
      talks = [talk1, talk2]

      session1 = double('Session', start_time: start_time, class: Break, type: 'Lunch')
      session2 = double('Session', start_time: start_time, class: Talk, talks: [talk1])
      track1 = double('Track', sessions: [session1, session2])

      session1 = double('Session', start_time: start_time, class: Break, type: 'Snacks')
      session2 = double('Session', start_time: start_time, class: Talk, talks: [talk1])
      track2 = double('Track', sessions: [session1, session2])

      tracks = [track1, track2]
      conference = double('conference')

      expect(Parser).to receive(:parse).with(file).and_return(talks)
      expect(Conference).to receive(:new).with(2).and_return(conference)
      expect(conference).to receive(:schedule).with(talks)
      expect(conference).to receive(:tracks).and_return(tracks)

      expect(STDOUT).to receive(:puts).with('-----------Track 1------------').ordered
      expect(STDOUT).to receive(:puts).with('11:10 AM Lunch').ordered
      expect(STDOUT).to receive(:puts).with('11:10 AM Talk1').ordered

      expect(STDOUT).to receive(:puts).with('-----------Track 2------------').ordered
      expect(STDOUT).to receive(:puts).with('11:10 AM Snacks').ordered
      expect(STDOUT).to receive(:puts).with('11:10 AM Talk1').ordered

      Manager.create_conference(2, file)
    end
  end
end
