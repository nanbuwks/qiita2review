#Re:VIEW を apache で動かす

「AWS上にRe:VIEW環境を構築する」
http://qiita.com/nanbuwks/items/da9136f1b6f789aaffcf

からの発展で、Re:VIEW を Web上で動かします。

「組版システムReVIEWでQiitaから同人誌原稿を作る」
http://qiita.com/nanbuwks/items/ad4ed8b7fbda846ba997

この仕組みを使ってQiitaにある記事を薄い本形式のPDFにするようにします。

## apache と PHP

apt-get install apache2
apt-get install libapache2-mod-php5

## DocumentRootにreview環境を展開
cd /var/www/html
review-init template
chown -R www-data:www-data *


## This account is currently not available.

コマンド実行でエラーが出たので/etc/passwdファイルの

として、www-dataでシェルログインできるようにします。

```
www-data:x:33:33:www-data:/var/www:/usr/sbin/nologin
```

↓

```
www-data:x:33:33:www-data:/var/www:/bin/bash
```

su - www-data

としてチェック。

・・・としていたのですが、ロケール設定だけの問題だったかも知れません。
現在は、ログオンシェルは /usr/sbin/nologin で運用しています。

## review環境を展開します。
review-init book

各種フォルダを作ります。

mkdir articles
mkdir template

## テンプレートを作ります。

```
cp book/config.yml template
cd template
vim config.yaml
```

config.yamlを適当に書きます。

書籍タイトル、著者、表紙を作らない、などを指定しておくといいでしょう。

複数人で執筆するので、
Qiitaの１つの記事が１章というようになります。

なのでQiitaの記事は

１人目

```
## 1人目の1章見出し
内容
### 1人目の1-2章見出し
内容
## 1人目の2章見出し
内容
```
２人目

```
## 2人目の1章見出し
内容
### 2人目の1-2章見出し
内容
## 2人目の2章見出し
内容
```
３人目

```
・
・
・
```

となりますが、これを


```
## 1人目のタイトル
1人目の肩書、名前
### 1人目の1章見出し
内容
#### 1人目の1-2章見出し
内容
### 1人目の2章見出し
内容
## 2人目のタイトル
2人目の肩書、名前
### 2人目の1章見出し
内容
#### 2人目の1-2章見出し
内容
### 2人目の2章見出し
内容
## 3人目のタイトル
・
・
・
```
とします。

なので、qiitaから取得したmarkdownは、見出しレベルを変更するスクリプトを通します。

```
sed "s/^#/##/"  qiita.md 
```

とすれば良いことになります。

qiita.mdはqiitaから取得したmarkdownです。qiitaからmarkdownを取得するにはwgetを使います。
こういったものも含めて、処理を行うシェルスクリプトを作ります。

```
## cat qiitaget.sh
URL=`ruby -Ku ../../makeurl.rb`
echo $URL
cd images

wget $URL -k -H -r -l 1 -nH -nd -A png,PNG,jpg,JPG,jpeg,JPEG,html  -R txt 
cd ..

rm qiita.md
wget $URL.md -O qiita.md
sed "s/^#/##/"  qiita.md | ruby -Ku ../../qiitamd.rb | ruby -Ku ../../texblock.rb | ruby -Ku ../../texinline.rb   > temp.md
head -1 temp.md | sed "s/^/#/" > $1.md
ruby  ../../makeauthor.rb  >> $1.md
tail -n +2 temp.md >> $1.md
ruby ../../escapeincode.rb $1.md | ruby ../../preprocess.rb |  md2review | ruby -Ku ../../scalemd.rb > $1.re
rake pdf
mv book.pdf $1.pdf

```
この、qiitaget.shはPHPからコマンド実行関数で呼び出します。

```
## cat compile.php 
<html>
<head>
<meta charset="UTF-8">
<title>qiita2review</title>
<style type="text/css">
body {
  color: #000;
  background-color: #ffffff;
}

pre {
  padding: 1em;
  color: #aaffaa;
  background-color: #aaaaaa;
}
</style>
</head>
<body>
<?php 

$sectionName = $_GET["section"];
?>
<h1>section <?php echo $sectionName; ?> compile</h1>




<pre>
<?php 
passthru("export LC_CTYPE=en_US.UTF-8; export LANG=en_US.UTF-8; cd articles/".$sectionName." ; ../../qiitaget.sh ".$sectionName);


  ?>

</pre>

<form action="<?php echo "articles/".$sectionName."/".$sectionName; ?>.pdf" METHOD="GET" >
<input type=submit value="View PDF">
</form>

<form action="make.php" METHOD="GET" >
<input type=hidden name=section value=<?php echo $sectionName; ?>>
<input type=submit value="return">


</form>
</body>
</html>

```

他のphpファイル、qiitaget.shから呼び出す各種フィルタスクリプトを作ります。

```
（省略・・・他記事を参照して下さい）

```

ファイルはwww-dataをオーナーにします。

```
## chown -R www-data:www-data *

```

ファイル一覧です

```
root@ip-172-30-0-222:/var/www/html# ls -alh
total 80K
drwxr-xr-x 5 www-data www-data 4.0K Apr  6 14:03 .
drwxr-xr-x 3 root     root     4.0K Apr  6 13:58 ..
drwxr-xr-x 4 www-data www-data 4.0K Apr  6 13:48 articles
drwxr-xr-x 5 www-data www-data 4.0K Apr  5 20:07 book
-rw-r--r-- 1 www-data www-data  803 Apr  5 03:48 compile.php
-rwxr-xr-x 1 www-data www-data  680 Apr  6 12:31 escapeincode.rb
-rw-r--r-- 1 root     root      213 Apr  6 14:03 .htaccess
-rw-r--r-- 1 www-data www-data 1.1K Apr  5 05:02 index.php
-rw-r--r-- 1 www-data www-data  235 Apr  4 16:19 makeauthor.rb
-rw-r--r-- 1 www-data www-data 1.4K Apr  5 20:18 make.php
-rw-r--r-- 1 www-data www-data   87 Apr  5 03:28 makeurl.rb
-rw-r--r-- 1 www-data www-data 1.2K Apr  5 05:11 new.php
-rwxr-xr-x 1 www-data www-data 2.0K Apr  5 19:11 preprocess.rb
-rwxrwxrwx 1 www-data www-data  536 Apr  6 12:58 qiitaget.sh
-rwxrwxrwx 1 www-data www-data  458 Apr  3 17:45 qiitamd.rb
-rwxrwxrwx 1 www-data www-data  222 Apr  4 13:41 scalemd.rb
-rwxr-xr-x 1 www-data www-data 1.4K Apr  6 09:11 slash2braceincode.rb
drwxr-xr-x 2 www-data www-data 4.0K Apr  4 18:23 template
-rwxrwxrwx 1 www-data www-data  286 Apr  4 12:20 texblock.rb
-rwxr-xr-x 1 www-data www-data 1.2K Apr  5 11:18 texinline.rb
```

閲覧系は誰でも見せますが、登録系はbasic認証でアクセス制限をかけます。

```
## cat .htaccess
<Files ~ "^\.(htaccess|htpasswd)$">
deny from all
</Files>
AuthUserFile /var/www/.htpasswd
AuthName "Please enter your ID and password"
AuthType Basic
order deny,allow
<Files new.php> 
require valid-user
</Files>
```

作成したサイトです

![Screenshot from 2017-04-07 09-50-56.png](images/7b11276e-74ae-e25a-0872-3726cec353fb.png)
