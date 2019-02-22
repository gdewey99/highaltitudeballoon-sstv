<html>
<head>

<title>SSTV Control</title>
</head>
        <body>
	<a href="./gallery/gallery.php">High Res Gallery</a>
	<a href="./lowgallery/gallery.php">Low Res Gallery</a>
	<p>
	<img src="./webcam.jpg" id="webcam"/>
	
<p><left>
	
	SSTV Control:
        <p>
	<left><form>
	<form method="get" action="index.php">
                <input type="submit" value="ON" name="on">
                <input type="submit" value="OFF" name="off">
        </form>
        <?php
        if(isset($_GET['on'])){
                shell_exec("/var/www/html/newsstv.sh > /dev/null 2>/dev/null &");
                echo "SSTV is on";
        }
        else if(isset($_GET['off'])){
                shell_exec("/var/www/html/kill.sh");
                echo "SSTV is off";
        }
        ?>
	</body>
</html>
