package Controllers::CommandCtrl::Router;

#user7 

#use utf8;
use Encode;
use warnings;
use strict;
#use Models::Utilits::File;
#use Data::Dumper;
use Models::Utilits::Debug;
use Models::Utilits::GetRout;
use Models::Utilits::Date;
use Models::Utilits::UseClass;

my $debug = Models::Utilits::Debug->new();
sub new
{
    my $class = ref($_[0])||$_[0];
    return bless({},$class);
}


sub go
{   

    my ($self,$tdir)=@_;
    my $date = Models::Utilits::Date->new();
    my @rout =Models::Utilits::GetRout->get() ;
    #print Dumper \@rout;
    #return @rout;
    my $tt=@rout;
    #print $tt;
    my $url=$rout[0];
    #$url='Admin';
    if(length($url)==0)
    {
        $url='Index';
        
    }
    else
    {
       $url=  ucfirst($url);
    }
    
    $date->{'nextpage'}=$url;
    my $temp =Models::Utilits::UseClass->_getCls('Controllers/CtrlPages/',$url,$rout[1] );
    #$date->{'nextpage'}=$url;
    $date->{'pageparam'}=$rout[1];
    return $temp;
    #########################
}



1;
