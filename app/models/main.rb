require_relative '../../app/models/manager'

class Main
  def self.main
    track_count = ARGV[0].to_i
    file_path = ARGV[1]

    Manager.create_conference(track_count, file_path)
  end
end

Main.main