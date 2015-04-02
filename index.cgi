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
use CGI qw(:cgi-lib :escapeHTML :unescapeHTML);
#use CGI::Carp qw(fatalsToBrowser); # позволит выводить ошибки в браузер
use Models::Utilits::Sessionme;
Config::Config->setDir(TDIR);

my $debug = Models::Utilits::Debug->new();


use Controllers::CommandCtrl::Router;
sub main
{


    my $date = Models::Utilits::Date->new();
    # это нужно перенсти во вюху
    my $cgi = CGI->new;
    my $session =  Models::Utilits::Sessionme->new($cgi);

    my $cookie = $cgi->cookie(CGISESSID => $session->getId());
    print $cgi->header( -cookie=>$cookie, -charset=>'utf-8');




    my $rout =Controllers::CommandCtrl::Router->new();



    my($t)=$rout->go(TDIR.'/');

    if($t)
    {
        $t->go();            
    }
    else
    {
        #print "no page";
        $date->{'nextpage'}='Error';
    }

    my $view = Views::View->new();
    $view->go(TDIR.'/');


    ##debug info
    #my $debug = Models::Utilits::Debug->new();
    #my $d=$debug->getMsg();
    #print  Dumper(\$d);
    #print $date->{'nextpage'};
}


main();
