<?php
// Start the buffering //
ob_start();
?>
<?php
  // Get the stuff from the query string
  $temperature = $_GET["temperature"];
  $people = $_GET["people"];
  $manualoverwrite = $_GET["manualoverwrite"];
  
  // Based on those values, pick an output
  if ($manualoverwrite == "yes") {
    //echo " I am jealous of your happiness.";
  } else {
    //echo " why so glum?";
  }

$xml = new SimpleXMLElement('<xml/>');

	$value = $xml->addChild('values');
	$value ->addChild('name', "temperature");
    $value ->addChild('value', "$temperature");
	
	$value = $xml->addChild('values');
	$value ->addChild('name', "people");
    $value ->addChild('value', "$people");
	
Header('Content-type: text/xml');
print($xml->asXML());

?>
<?php
file_put_contents('values.xml', ob_get_contents());
?>