#!/usr/bin/env ruby

require 'mechanize'
require "open-uri"

start_chapter = ARGV[0]
end_chapter = ARGV[1]

PAGE = 'http://www.mangareader.net/bleach'

(start_chapter.to_i .. end_chapter.to_i).each do |chapter|
  begin
    Dir.mkdir(File.join(Dir.home, 'manga', 'bleach', chapter.to_s))
    puts "created dir #{chapter}"
  rescue Exception => e
    puts "no dir created for #{chapter}", e
    return
  end

  (1 .. 25).each do |page|
    begin
      agent = Mechanize.new
      p = agent.get([PAGE, chapter.to_s, page.to_s].join("/"))
      image = p.image_urls.first

      File.open(File.join(Dir.pwd, chapter.to_s, "%02d.jpg" % page), 'wb') do |f|
        f.write open(image).read
      end
      puts "stored #{chapter} #{page}"
    rescue Exception => e
#      puts "yo dawg something went wrong:\tchapter: #{chapter}\tpage: #{page}", e
      next
    end
  end

end


