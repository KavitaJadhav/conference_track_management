require 'time'
require 'pry'
require_relative '../../app/models/track'
require_relative '../../app/models/talk'
require_relative '../../app/models/break'
require_relative '../../app/lib/constants'
require_relative '../../app/utils/time_util'
# require in loop

class Conference
  def initialize number_of_tracks
    @tracks = []
    1.upto(number_of_tracks) { @tracks << Track.new }
  end

  def schedule talks
    talks.each do |talk|
      schedule_talk(talk)
    end

    schedule_custom_talks
    return @tracks
  end

  private

  def schedule_talk(talk)
    if schedule_in_sessions(@tracks[0].morning_session, @tracks[1].morning_session, talk)
    else
      schedule_in_sessions(@tracks[0].afternoon_session, @tracks[1].afternoon_session, talk)
    end
  end

  def schedule_in_sessions(session1, session2, talk)
    if session1.talks.size > session2.talks.size && session2.time_available > talk.duration
      session2.add_talk(talk)
    elsif session1.time_available > talk.duration
      session1.add_talk(talk)
    elsif session2.time_available > talk.duration
      session2.add_talk(talk)
    else
      false
    end
  end

  def schedule_custom_talks
    networking_talk = Talk.new('networking', 60)
    afternoon_session_time_avaliable = (@tracks[0].afternoon_session.time_available - @tracks[1].afternoon_session.time_available).abs
    expected_start_time_min = Time.at(Constants::Session::Networking::EXPECTED_START_TIME_MIN)
    expected_start_time_max = Time.at(Constants::Session::Networking::EXPECTED_START_TIME_MAX)
    calculated_start_time = TimeUtil.minute_back(expected_start_time_max, afternoon_session_time_avaliable)

    @tracks[0].afternoon_session.add_talk(networking_talk)
    @tracks[1].afternoon_session.add_talk(networking_talk)
    networking_talk.start_time = expected_start_time_min > calculated_start_time ? expected_start_time_min : calculated_start_time
  end
end