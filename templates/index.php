<?php
include ('config.php');
include (LIBS.'/functions.php');

try
{
  $obj = new Controller();
}
catch(Exception $e)
{
  echo $e->getMessage();	           
}






