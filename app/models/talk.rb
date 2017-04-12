class Talk
  attr_reader :title, :duration
  attr_accessor :start_time

  def initialize title, duration
    @title = title
    @duration = duration
    @start_time = nil
  end
end