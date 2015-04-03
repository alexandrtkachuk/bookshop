package Controllers::CtrlPages::Addbook;

use warnings;
use strict;

use Config::Config;

use Data::Dumper;
use Models::Utilits::Date;
use Models::Performers::Admin;
my $debug = Models::Utilits::Debug->new();

use vars qw(%in);
use Models::Utilits::Email::Valid;
use CGI qw(:cgi-lib :escapeHTML :unescapeHTML);

ReadParse();





sub new
{

    my $class = ref($_[0])||$_[0];
    return bless({      },$class);
}

sub go
{
    my $data = Models::Utilits::Date->new();

    my ($self)=@_;

     my $admin= Models::Performers::Admin->new();
    #$admin->add( 'admin','admin','admin@mail.ru');
    $debug->setMsg( Dumper \%in );
    
    unless($admin->isLogin())
    {
        #переходим на главную страницу админа 
        $data->{'redirect'}=Config::Config->getBaseUrl().'login';

    }
    
    return 1;    

}


1;
