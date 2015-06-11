require 'open-uri'

module Stiller
  class Webm
    def self.from_url(url)
      tempfile = Tempfile.new('webm')
      open(url) do |file|
        tempfile.write(file.read)
        tempfile.flush
      end
      self.new(tempfile)
    end

    def initialize(file)
      @file = file
    end

    def still
      outfile = Tempfile.new('output.png')
      `ffmpegthumbnailer -i #{@file.path} -o #{outfile.path} -s 0`
      outfile
    end
  end
end
