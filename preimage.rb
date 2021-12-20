#!/usr/bin/env ruby
# this is not support $...$ in inline htmltag,link,image.
codeBlock=false
incomment=true
while line = gets
  line.chomp!
  if ( codeBlock == false && md1 = line.match(/^```/))
      # code block start
      codeBlock=true
      puts line
  elsif ( codeBlock == true && md1 = line.match(/^```/))
      # code block end
      codeBlock=false
      puts line
  elsif ( codeBlock == false && md1 = line.match(/^\[\]\(\ *review:(.*)\ *\)/))
      # review command (see https://github.com/repeatedly/ReVIEW/blob/master/doc/format.txt )
      # [](review://pagebreak) →  //pagebreak
      puts md1[1]
#  elsif ( codeBlock == false && md1 = line.match(/^\[\]\(\ *(scale=.*)\ *\)!\[.*\]\(.*\)/))
#      # picture scale with discription
#      # [](scale=0.5)![aaa](http:....) →  [scale=0.5]![aaa](http:....)
#      md2 = line.match(/^\[\]\(\ *scale=.*\ *\)(!\[.*\]\(.*\))/)
#      print "[" + md1[1] + "]" + md2[1]
#  elsif ( codeBlock == false && md1 = line.match(/^.*!\[.*\]\(.*\)/))
#      # non scaled picture with discription
#      puts line
  elsif ( codeBlock == false && md1 = line.match(/(<[iI][mM][gG]\s.*>)/))
      puts "---------------------------------------"
      puts md1[0]
      puts md1[1]
      puts "---------------------------------------"
      # picture scale with clear discription
      # [](scale=0.5)![aaa](http:....) →  [scale=0.5]![](http:....)
      # md2 = line.match(/^\[\]\(\ *scale=.*\ *\)!\[.*\](\(.*\))/)
      # puts "[" + md1[1] + "]![]" + md2[1]
  elsif ( codeBlock == false && md1 = line.match(/^.*!\[.*\](\(.*\))/))
      # non scaled picture with clear discription
      # ![aaa](http:....) →  ![](http:....)
      puts "![]" + md1[1]
  elsif ( codeBlock == false )
    offset=0
    while md1 = line.index("[](",offset) do
      # comment
      thereistex=false
      if ( md2 = line.match(/\$.*?\$/))
        thereistex=true
      end 
      inlinecode="nocode"
      inlinetex="notex"
      # inline command 
      # check of inline code until start []( 
      for  num in offset..md1-1
         ch = line[num]
         #   ` ~ ` check
         if ( ch == "`" && inlinecode=="nocode" )
             inlinecode="starting"
         elsif ( ch != "`" && inlinecode=="starting" )
            inlinecode="incode"
         elsif ( ch == "`" && inlinecode=="incode" )
            inlinecode="ending"
         elsif ( ch != "`" && inlinecode=="ending" )
            inlinecode="nocode"
         #   $ ~ $ check
         elsif ( ch == "$" && inlinecode=="nocode" && inlinetex=="notex" && thereistex==true )
            inlinetex="intex"
         elsif ( ch == "$" && inlinecode=="nocode" && inlinetex=="intex" )
            inlinetex="notex"
         end
         print "'"
         print ch
         print "'"
      end
      offset=md1+4
      num=offset-1
      if ( inlinetex!="notex" || inlinecode!="nocode")
      else 
        incomment=true
        # comment pass loop
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
    # code block
    puts line
  end
end

