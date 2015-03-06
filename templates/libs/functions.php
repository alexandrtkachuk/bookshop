<?php

    function __autoload($class ){

        require_once(LIBS.'/'.$class.'.php' );

    }

