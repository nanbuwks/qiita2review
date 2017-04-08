#!/usr/bin/env ruby
# this is not support $...$ in inline htmltag,link,image.
codeBlock=false
incomment=true
isThereSlash2Brace="no"
File.open(ARGV[0], "r") do |f|
  lines=f.read.split("\n")
  maxcount=lines.length-1
  for linecount in 0..maxcount do
#    print codeBlock," ",isThereSlash2Brace,"'"
    line=lines[linecount]
    line.chomp!
    if ( codeBlock == false &&  line.match(/^```/))
	codeBlock=true
	puts line
    elsif ( codeBlock == true && md1 = line.match(/^```/))
	codeBlock=false
	puts line
    elsif ( codeBlock == true )
        line=line.gsub(/\@/, "@<raw>{@}")
        line.gsub!(/\/\/}/, "@<raw>{//}}")
        puts line
    else
	puts line
    end
  end
end
