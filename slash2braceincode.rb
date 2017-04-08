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
	isThereSlash2Brace="checking"
	codeBlock=true
	startlinecount = linecount+1
	puts line
    elsif ( codeBlock == true && md1 = line.match(/^```/) && isThereSlash2Brace=="yes")
	endlinecount = linecount
	linecount = startlinecount
	while linecount<endlinecount do
          codeline=lines[linecount]
	  codeline.chomp!
	  print " "
	  puts codeline
          linecount=linecount+1
	end
	isThereSlash2Brace="no"
	codeBlock=false
	puts line
    elsif ( codeBlock == true && md1 = line.match(/^```/) && isThereSlash2Brace=="checking")
	endlinecount = linecount
	linecount = startlinecount
	while linecount<endlinecount do
          codeline=lines[linecount]
	  codeline.chomp!
	  puts codeline
          linecount=linecount+1
	end
	isThereSlash2Brace="no"
	codeBlock=false
	puts line
    elsif ( codeBlock == true && md1 = line.match(/^\/\/\}/) && isThereSlash2Brace=="checking")
        isThereSlash2Brace="yes"
    elsif ( codeBlock == true )
    else
	puts line
    end
  end
end
