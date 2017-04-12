require_relative '../../app/utils/time_util'

describe TimeUtil do
  let(:date) { Time.at(0) }
  let(:minutes) { 30 }

  describe '#minute_back' do
    it 'should subtract minutes from time' do
      expect(TimeUtil.minute_back(date, minutes).to_s).to eq('1970-01-01 05:00:00 +0530')
    end
  end

  describe '#minute_later' do
    it 'should add minutes in time' do
      expect(TimeUtil.minute_later(date, minutes).to_s).to eq('1970-01-01 06:00:00 +0530')
    end
  end
end
