URL=`ruby -Ku ../../makeurl.rb`
echo $URL


rm qiita.md
rm qiitaall.md
wget $URL.md -O qiitaall.md



# change qiita md old format 

sed '1,/---/d' qiitaall.md > qiitanopreample.md    # yaml preample delete
cat qiitanopreample.md | sed "s/^\(\x23\x23*\)\s*/\1 /g" > normalmd1.md # add space at heading if no space ,  x23 is # , for vim malfunction


python3 ../../mdmd/mdmd.py  normalmd1.md > normalmd2.md # image html / qiita paragraph to normal markdown


cd images
#wget $URL -k -H -r -l 1 -nH -nd -A png,PNG,jpg,JPG,jpeg,JPEG,html  -R txt 
cat ../normalmd2.md | awk 'match($0, /!\[(.*)\]\((.*)\)/, a) {print a[2]}' | sed s/\"//g > images.list
wget -N -i images.list
cd ..

# qiita md file to local md file.
cat  normalmd2.md | ruby -Ku ../../qiitamd.rb | ruby -Ku ../../texblock.rb | ruby -Ku ../../texinline.rb   > temp.md
sed -n 2p qiitaall.md | sed s/"title: "/"# "/ > $1.md
# Because single author case, to make author section is manually.
ruby  ../../makeauthor.rb  >> $1.md
sed "s/^#/##/" temp.md >> $1.md

# extention markdown to review command
ruby ../../escapeincode.rb $1.md | ruby ../../preprocess.rb |  md2review | ruby -Ku ../../scalemd.rb > $1.re
rake pdf
mv book.pdf $1.pdf
