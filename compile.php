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
passthru("export LC_CTYPE=en_US.UTF-8; export LANG=en_US.UTF-8; cd articles/".$sectionName." ; ../../qiitaget.sh > /dev/null ".$sectionName);


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

