class Break
  attr_reader :start_time, :type

  def initialize
    @start_time= Time.at(23400)
    @type= 'Lunch'
  end
end