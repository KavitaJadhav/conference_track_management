require_relative '../../app/models/parser'
require_relative '../../app/models/conference'
require_relative '../../app/models/break'

class Manager

  class << self
    def create_conference(track_count, file)
      talks = Parser.parse(file)

      conference = Conference.new(track_count)
      conference.schedule(talks)
      print_schedule conference.tracks
    end

    def print_schedule tracks
      time_display_format = '%H:%M %p'

      tracks.each_with_index do |track, index|
        puts "-----------Track #{index+1}------------"
        track.sessions.each do |session|
          if session.class == Break
            puts "#{session.start_time.strftime(time_display_format)} #{session.type}"
          else
            session.talks.each do |talk|
              puts "#{talk.start_time.strftime(time_display_format)} #{talk.title}"
            end
          end
        end
      end
    end
  end
end
