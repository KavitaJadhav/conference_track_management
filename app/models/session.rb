class Session
  attr_reader :duration, :start_time
  attr_accessor :time_available

  def initialize(start_time, duration=0)
    @duration = duration
    @time_available = duration
    @start_time = start_time
  end

  def talks
    @talks ||= []
  end

  def add_talk talk
    talks << talk
    talk.start_time = TimeUtil.minute_back end_time, time_available
    talk.scheduled = true
    @time_available -= talk.duration
  end

  private
  def end_time
    @end_time ||= TimeUtil.minute_later start_time, duration
  end
end