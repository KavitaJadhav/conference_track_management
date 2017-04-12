require_relative '../../app/models/track'
require_relative '../../app/lib/constants'

class Parser
  def self.parse file_path
    lines = File.readlines(file_path)

    lines.map do |line|
      time = line.gsub(/[^\d]/, '')
      time = time.empty? ? Constants::Talk::Lightning::DURATION : time.to_i
      Talk.new(line, time)
    end
  end
end
