#!/usr/bin/env ruby
# encoding: utf-8

while line = gets
  line.chomp!
  if md1 = line.match(/(^!\[.*?\]\()/)
    if md2 = line.match(/([^\/]*\))/)
#      puts line
#      print md1[0],"\n"
#      print md1[1],"\n"
#      print md2[0],"\n"
#      print md2[1],"\n"
#      print "\n"
#      print md2[0],md1[0],"{\n"
      print md1[0]
      print "images/"
      print md2[1]
      print "\n"
    else
      puts line
    end
  else
   puts line
  end
end


