# app/services/video_converter.rb

class VideoConverter
  def initialize(call_id)
    @call = Call.find(call_id)
  end

  def convert!
    process_video
  end

  private

  def process_video
    @call.video.open(tmpdir: "/tmp") do |file|
      movie = FFMPEG::Movie.new(file.path)
      path = "tmp/video-#{SecureRandom.alphanumeric(12)}.mp4"
      movie.transcode(path, {
        video_codec: 'libx264', audio_codec: 'aac', resolution: calculate_resolution(movie.width/2, movie.height/2)#, quality: 5
      })
      @call.video.attach(io: File.open(path), filename: "video-#{SecureRandom.alphanumeric(12)}.mp4", content_type: 'video/mp4')
    end
  end

  def calculate_resolution(width, height)
    width = width + 1 unless width % 2 == 0
    height = height + 1 unless height % 2 == 0
    "#{width}x#{height}"
  end
end