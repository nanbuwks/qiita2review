require 'yaml'
 
yaml = YAML.load_file('qiita2review.yml')
url = yaml["url"]
print url
