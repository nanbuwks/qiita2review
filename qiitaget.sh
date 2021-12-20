URL=`ruby -Ku ../../makeurl.rb`
echo $UR


rm qiita.md
rm qiitaall.md
wget $URL.md -O qiitaall.md
# change qiita md old format 
sed -n 2p qiitaall.md | sed s/"title: "// > qiita.md
tail -n +7 qiitaall.md >> qiita.md

cd images
# wget $URL -k -H -r -l 1 -nH -nd -A png,PNG,jpg,JPG,jpeg,JPEG,html  -R txt 
cat ../qiita.md | awk 'match($0, /!\[(.*)\]\((.*)\)/, a) {print a[2]}' > images.list
wget -N -i images.list
cd ..

# qiita md file to local md file.
sed "s/^#/##/"  qiita.md | ruby -Ku ../../qiitamd.rb | ruby -Ku ../../texblock.rb | ruby -Ku ../../texinline.rb   > temp.md
head -1 temp.md | sed "s/^/#/" > $1.md
# Because single author case, to make author section is manually.
# ruby  ../../makeauthor.rb  >> $1.md
tail -n +2 temp.md >> $1.md

# extention markdown to review command
ruby ../../escapeincode.rb $1.md | ruby ../../preprocess.rb |  md2review | ruby -Ku ../../scalemd.rb > $1.re
rake pdf
mv book.pdf $1.pdf
