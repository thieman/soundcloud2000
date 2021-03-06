require_relative '../audio_player/player'

module Soundcloud2000
  class Player
    attr_reader :track

    def initialize(logger)
      @logger = logger
      @track = nil
      @audio = AudioPlayer::Player.new(@logger)
    end

    def play(track, location, &callback)
      @track = track
      @location = location

      @logger.warn @track.inspect

      load(&callback)
    end

    def toggle
      @audio.toggle
    end

    def playing?
      @audio.playing?
    end

    def rewind
      @audio.rewind
    end

    def forward
      @audio.forward
    end

    def play_progress
      @audio.play_progress
    end

    def seconds_played
      @audio.seconds_played
    end

    def spectrum
      @audio.spectrum
    end

    def title
      [@track.title, @track.user.username].join(' - ')
    end

  protected

    def load(&callback)
      @audio.load(@location, @track.id) do |audio|
        yield
      end
      @audio.start
    end

  end
end
