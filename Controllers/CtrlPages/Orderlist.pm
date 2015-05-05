package Controllers::CtrlPages::Orderlist;

use warnings;
use strict;

use Config::Config;

use Data::Dumper;
use Models::Utilits::Date;
use Models::Performers::Admin;
my $debug = Models::Utilits::Debug->new();

use vars qw(%in);
use Email::Valid;
use CGI qw(:cgi-lib :escapeHTML :unescapeHTML);

ReadParse();

sub new()
{   
    my $class = ref($_[0])||$_[0];
    return bless({},$class);
}

sub go
{
    my ($self)=@_;
    my $user =  Models::Performers::User->new();
    my $data = Models::Utilits::Date->new();
 
    if($user->isLogin())
    {
        $data->{'nextpage'}='Orderlist';
    }
    else 
    {
        #$date->{'nextpage'}='Login';
        $data->{'redirect'}=Config::Config->getBaseUrl().'login';
        return 0;
    }

    if ($in{'iduser'})
   {
        $data->{'iduser'} = $in{'iduser'};
   }
   
    return 1;
}



1;