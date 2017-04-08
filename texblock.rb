#!/usr/bin/env ruby

math=false
while line = gets
  line.chomp!
  if ( math == false && md1 = line.match(/^```math/))
      math=true
      print "//texequation{\n"
  elsif ( math == true && md1 = line.match(/^```/))
      math=false
      print "//}\n"
  elsif ( math == true && md1 = line.match(/^[:blank:]*$/))
  else
    puts line
  end
end

