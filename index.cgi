#!/usr/bin/perl 

use warnings;
use strict;
$|=1;

use Data::Dumper;
use File::Basename;;

use constant TDIR=>dirname(__FILE__);
use lib TDIR;
use lib TDIR.'/Libs';

use Models::Utilits::Date;
use Models::Utilits::Debug;
use Views::View;
use Config::Config;
use Controllers::CommandCtrl::Router;

Config::Config->setDir(TDIR);
my $debug = Models::Utilits::Debug->new();

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
    #print $date->{'pageparam'};
    #print Config::Config->getBaseUrl();
}
###run to main
main();
