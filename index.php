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
<h1>qiita2review</h1>



<hr>
<h2>available artile title</h2>
<pre>
<?php 
passthru("ls -l articles | grep '^d' | awk '{print \"<a href=make.php?section=\" $9 \">\",$6,$7,$8,$9,\"</a><br>\"}' ");
?>

</pre>



<hr>
<h2>Add new article title</h2>
<form action="new.php" METHOD="GET" >

<input type=text name="section"> 記事を区別するわかりやすい名前（英数字）この名前がファイル名などに使われます。 ex,orbitcal なおここの名前とは別に記事名はQiitaより自動で取得されます<br>
<input type=text name="url"> Qiita上の記事のURL ex,http://qiita.com/nanbuwks/items/9b00e8012e328de6e440<br>
<input type=text name="author">著者名 ex, 河野悦昌</br>
<input type=text name="affili">所属　ex, 秘密結社オープンフォース</br>
<input type=submit>
</form>


</body>
</html>

