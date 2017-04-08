#!/usr/bin/env ruby

while line = gets
  line.chomp!
  if md1 = line.match(/^\[.*?\]/)
    if md2 = line.match(/\/\/(.+)\]/)
      print md2[0],md1[0],"{\n"
    else
      puts line
    end
  else
    puts line
  end
end

