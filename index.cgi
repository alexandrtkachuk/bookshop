#!/usr/bin/perl 

use warnings;
use strict;
use Data::Dumper;
use File::Basename;
$|=1;

# текущяя дериктория
#use constant TDIR=>'/home/alexandr/www/html/olx/'; 
use constant TDIR=>dirname(__FILE__);
use lib TDIR;
use lib TDIR.'/Models/Utilits';

use Models::Utilits::Date;
use Models::Utilits::Debug;
use Views::View;
use Config::Config;

Config::Config->setDir(TDIR);




my $debug = Models::Utilits::Debug->new();


use Controllers::CommandCtrl::Router;
sub main
{


    my $date = Models::Utilits::Date->new();
    my $debug = Models::Utilits::Debug->new();   



    my $rout =Controllers::CommandCtrl::Router->new();



    my($t)=$rout->go(TDIR.'/');

    if($t)
    {
        eval 
        { 
            $t->go();   
        };
        if($@) 
        {  
            $debug->setMsg($@);
        }         
    }
    else
    {
        #print "no page";
        $date->{'nextpage'}='Error';
    }

    my $view = Views::View->new();
    $view->go(TDIR.'/');
    

   
    ##debug info
    my $d=$debug->getMsg();
    #print  Dumper(\$d);
    #print $date->{'nextpage'};
    #print Config::Config->getBaseUrl();

}


main();
