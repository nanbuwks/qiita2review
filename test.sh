URL=`ruby -Ku ../../makeurl.rb`

cat qiita.md | awk 'match($0, /!\[(.*)\]\((.*)\)/, a) {print a[2]}' 
