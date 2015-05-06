package Controllers::CtrlPages::Userlist;

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
        $data->{'nextpage'}='Userlist';
    }
    else 
    {
        $data->{'redirect'}=Config::Config->getBaseUrl().'login';
        return 0;
    }
    
    return 1;
}

1;