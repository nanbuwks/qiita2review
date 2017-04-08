#!/usr/bin/env ruby
# this is not support $...$ in inline htmltag,link,image.
codeBlock=false
incomment=true
while line = gets
  line.chomp!
  if ( codeBlock == false && md1 = line.match(/^```/))
      codeBlock=true
      puts line
  elsif ( codeBlock == true && md1 = line.match(/^```/))
      codeBlock=false
      puts line
  elsif ( codeBlock == false && md1 = line.match(/^\[\]\(\ *(scale=.*)\ *\)!\[.*\]\(.*\)/))
      md2 = line.match(/^\[\]\(\ *scale=.*\ *\)(!\[.*\]\(.*\))/)
      print "[" + md1[1] + "]" + md2[1]
  elsif ( codeBlock == false )
    offset=0
    while md1 = line.index("[](",offset) do
      thereistex=false
      if ( md2 = line.match(/\$.*?\$/))
        thereistex=true
      end 
      inlinecode="nocode"
      inlinetex="notex"
      for  num in offset..md1-1
         ch = line[num]
         if ( ch == "`" && inlinecode=="nocode" )
             inlinecode="starting"
         elsif ( ch != "`" && inlinecode=="starting" )
            inlinecode="incode"
         elsif ( ch == "`" && inlinecode=="incode" )
            inlinecode="ending"
         elsif ( ch != "`" && inlinecode=="ending" )
            inlinecode="nocode"
         elsif ( ch == "$" && inlinecode=="nocode" && inlinetex=="notex" && thereistex==true )
            inlinetex="intex"
         elsif ( ch == "$" && inlinecode=="nocode" && inlinetex=="intex" )
            inlinetex="notex"
         end
         print ch
      end
      offset=md1+4
      num=offset-1
      if ( inlinetex!="notex" || inlinecode!="nocode")
      else 
        incomment=true
        while incomment==true do
          if ( line.length < num )
            if ( line=gets )
              num=0
            else
              incomment=false
            end
          end
          ch=line[num]

          if ( ch == ")" )
            incomment=false
          end
          num=num+1
          offset=num
        end
      end
    end
    line=line[offset,line.length]
    puts line
  else
    puts line
  end
end

