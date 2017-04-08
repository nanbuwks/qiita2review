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

$author = $_GET["author"];
$affili = $_GET["affili"];
$url = $_GET["url"];
$section = $_GET["section"];

?>
<h1>new <?php echo $section ?></h1>

<pre>
<?php 
passthru("export LANG=en_US.UTF-8;cd articles;review-init ".$section);
passthru("cp template/config.yml articles/".$section."/");
?>
<?php
$file = "articles/".$section."/qiita2review.yml";
$fp = fopen($file, 'w');
fwrite($fp, 'url: "'.$url."\"\n");
fwrite($fp, 'aut: "'.$author."\"\n");
fwrite($fp, 'affili: "'.$affili."\"\n");
fclose($fp);


$file = "articles/".$section."/catalog.yml";
$fp = fopen($file, 'w');
fwrite($fp, "PREDEF:\n");
fwrite($fp, "\n");
fwrite($fp, "CHAPS:\n");
fwrite($fp, "  - ".$section.".re\n");
fwrite($fp, "\n");
fwrite($fp, "APPENDIX:\n");
fwrite($fp, "\n");
fwrite($fp, "POSTDEF:\n");
fwrite($fp, "\n");
fclose($fp);
?>

<hr>
<h1>available artile title</h1>

</pre>



<hr>
<form action="index.php" METHOD="GET" >
<input type=submit value="return">
</form>


</body>
</html>

