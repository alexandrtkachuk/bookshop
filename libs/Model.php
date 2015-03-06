<?php 

class Model
{ 
   public function __construct()
   {

   }
   	
	public function getArray()
    {    
        $content['%TITLE%']= TASK;
        $content['%ERRORS%']= '';
        $content['%NAME%']=TASK;
        $content['%CONTENT%']=' content ';


		return $content;
   }
	
}
