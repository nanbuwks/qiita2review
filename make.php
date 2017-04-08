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
.scr {
  overflow: scroll;
  width: 100%;
  height: 100%;
}
</style>

</head>
<body>
<?php 

$sectionName = $_GET["section"];
?>
<h1>section <?php echo $sectionName; ?></h1>
<pre>
<?php
passthru("cat articles/".$sectionName."/qiita2review.yml");
?>
</pre>





original qiita address: <a href="<?php passthru("cd articles/".$sectionName."; ruby ../../makeurl.rb"); ?>"><?php passthru("cd articles/".$sectionName."; ruby ../../makeurl.rb"); ?></a> <br>
<?php
$filename = "articles/".$sectionName."/".$sectionName.".md";
if (file_exists( $filename )) {
?>
<div class="scr">
<pre>
<?php
  passthru("cat ".$filename);
?>
</pre>
</div>
<?php
}
?>



<?php
$filename = "articles/".$sectionName."/".$sectionName.".pdf";
if (file_exists( $filename )) {
?>
<div>
<object data="<?php echo $filename;?>" width="100%" height="100%">
</object>
</div>
<?php
}
?>


<form action="compile.php" METHOD="GET" >
<input type=hidden name=section value=<?php echo $sectionName; ?>>
<input type=submit value="Compile"> ( wait a minute )
</form>
<form action="<?php echo "articles/".$sectionName."/".$sectionName; ?>.pdf" METHOD="GET" >
<input type=submit value="View PDF">
</form>

<a href=index.php>top</a>

</body>
</html>
