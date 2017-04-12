require_relative '../../app/models/session'
require_relative '../../app/lib/constants'
require_relative '../../app/utils/time_util'

class Track
  attr_accessor :sessions

  def initialize
    @sessions = [morning_session, Break.new, afternoon_session]
  end

  def morning_session
    @morning_session ||= Session.new(Time.at(Constants::Session::Morning::START_TIME), Constants::Session::Morning::DURATION)
  end

  def afternoon_session
    @afternoon_session ||= Session.new(Time.at(Constants::Session::Afternoon::START_TIME), Constants::Session::Afternoon::DURATION)
  end
end