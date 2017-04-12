require_relative '../../app/lib/constants'

class TimeUtil
  class << self
    def minute_back(date, minutes)
      date - minutes * Constants::Time::MINUTES_IN_HOUR
    end

    def minute_later(date, minutes)
      date + minutes * Constants::Time::MINUTES_IN_HOUR
    end
  end
end