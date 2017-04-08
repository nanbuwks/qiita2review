URL=`ruby -Ku ../../makeurl.rb`
echo $URL
cd images

wget $URL -k -H -r -l 1 -nH -nd -A png,PNG,jpg,JPG,jpeg,JPEG,html  -R txt 
cd ..

rm qiita.md
wget $URL.md -O qiita.md
sed "s/^#/##/"  qiita.md | ruby -Ku ../../qiitamd.rb | ruby -Ku ../../texblock.rb | ruby -Ku ../../texinline.rb   > temp.md
head -1 temp.md | sed "s/^/#/" > $1.md
# ruby  ../../makeauthor.rb  >> $1.md
tail -n +2 temp.md >> $1.md
ruby ../../escapeincode.rb $1.md | ruby ../../preprocess.rb |  md2review | ruby -Ku ../../scalemd.rb > $1.re
rake pdf
mv book.pdf $1.pdf
