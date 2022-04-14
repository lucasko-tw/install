<?php
// Create connection to Oracle
$conn = oci_connect("system", "1qaz@WSX1234", "//192.168.0.10:1521/orcl");
if (!$conn) {
   $m = oci_error();
   echo $m['message'], "\n";
   exit;
}
else {
   print "Connected to Oracle!";
}
// Close the Oracle connection
oci_close($conn);
?>