#!/usr/bin/env ruby
# this is not support $...$ in inline htmltag,link,image.
codeBlock=false
while line = gets
  line.chomp!
  escape = false
  if ( codeBlock == false && md1 = line.match(/^```/))
      codeBlock=true
      puts line
  elsif ( codeBlock == true && md1 = line.match(/^```/))
      codeBlock=false
      puts line
  elsif ( codeBlock == false && md1 = line.match(/\$.*?\$/))
    inlinecode="nocode"
    inlinetex="notex"
    line.each_char {|ch|
            if ( escape == true )
              escape = false
	      if ( ch == "$" )
		  print ch
	      else
		  print "\\"
		  print ch
	      end
	    else
	      if ( ch == "\\" && inlinecode=="nocode" )
		escape = true
	      else
		if ( ch == "`" && inlinecode=="nocode"  )
		  inlinecode="starting"
		elsif ( ch != "`" && inlinecode=="starting" )
		  inlinecode="incode"
		elsif ( ch == "`" && inlinecode=="incode"  )
		  inlinecode="ending"
		elsif ( ch != "`" && inlinecode=="ending" )
		  inlinecode="nocode"
		elsif ( ch == "$" && inlinecode=="nocode" && inlinetex=="notex" )
		  ch = "@<m>{"
		  inlinetex="intex"
		elsif ( ch == "$" && inlinecode=="nocode" && inlinetex=="intex" )
		  ch = "}"
		  inlinetex="notex"
		elsif ( ch == "}" && inlinecode=="nocode" && inlinetex=="intex" )
		  print "\\\\"
		end
		print ch
	      end
	    end
    }
    puts ""
  else
    puts line
  end
end

