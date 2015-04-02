package Controllers::CtrlPages::Logout;

use warnings;
use strict;

use Config::Config;
use Models::Performers::User;
use Models::Utilits::Date;

sub new
{

    my $class = ref($_[0])||$_[0];
    return bless({      },$class);
}

sub go
{

    my $user= Models::Performers::User->new();
    
    my $data = Models::Utilits::Date->new();
    
    $user->logout();

    
    $data->{'redirect'}=Config::Config->getBaseUrl();


    return 1;



}


1;
