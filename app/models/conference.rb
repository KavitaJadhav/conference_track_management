require 'time'
require 'pry'
require_relative '../../app/models/track'
require_relative '../../app/models/talk'
require_relative '../../app/models/break'
require_relative '../../app/lib/constants'
require_relative '../../app/utils/time_util'
# require in loop

class Conference
  attr_reader :tracks

  def initialize number_of_tracks
    @tracks = []
    1.upto(number_of_tracks) { @tracks << Track.new }
  end

  def schedule talks
    talks.each { |talk| schedule_talk(talk) }

    schedule_custom_talks
  end

  private

  def schedule_talk(talk)
    schedule_in_sessions(@tracks.map(&:morning_session), talk)
    schedule_in_sessions(@tracks.map(&:afternoon_session), talk) unless talk.scheduled
  end

  def schedule_in_sessions(sessions, talk)
    session = sessions.select { |session| session.time_available > talk.duration }.sort_by { |session| session.time_available }.last
    session.add_talk talk if session
  end

  def schedule_custom_talks
    networking_talk = Talk.new('Networking', 60)

    afternoon_session_time_avaliable = @tracks.map { |track| track.afternoon_session.time_available }.min
    expected_start_time_min = Time.at(Constants::Session::Networking::EXPECTED_START_TIME_MIN)
    expected_start_time_max = Time.at(Constants::Session::Networking::EXPECTED_START_TIME_MAX)
    calculated_start_time = TimeUtil.minute_back(expected_start_time_max, afternoon_session_time_avaliable)

    @tracks.each { |track| track.afternoon_session.add_talk(networking_talk) }
    networking_talk.start_time = expected_start_time_min > calculated_start_time ? expected_start_time_min : calculated_start_time
  end
end