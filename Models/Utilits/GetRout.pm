package Models::Utilits::GetRout;

#user7
use warnings;
use strict;



sub get 
{
    my @sname=split /\//, $ENV{'SCRIPT_NAME'} ;

    my $test= $ENV{'REQUEST_URI'} ;

    for(@sname)
    {   
        $test=~s/$_\///;
        #print $_ ;
    }
    my @rout = split /\//, $test;
    #print $test;
    return @rout;
	
}



1;
