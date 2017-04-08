require 'yaml'
 
yaml = YAML.load_file('qiita2review.yml')
author = yaml["aut"]
affili = yaml["affili"]

puts "//raw[|latex| \\begin{center} ]"

print author
print "  *"
print affili
print "*"
puts
puts "//raw[|latex| \\end{center} ]"
