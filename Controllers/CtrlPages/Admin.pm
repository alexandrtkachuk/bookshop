package Controllers::CtrlPages::Admin;

use warnings;
use strict;

use Config::Config;



use vars qw(%in);
use Models::Utilits::Email::Valid;
use CGI qw(:cgi-lib :escapeHTML :unescapeHTML);

ReadParse();

use Data::Dumper;
use Models::Utilits::Date;
use Models::Performers::Admin;
my $debug = Models::Utilits::Debug->new();


#module which is responsible for admin page
#
my $Data={};


sub new
{

    my $class = ref($_[0])||$_[0];
    return bless({      },$class);
}

sub go
{
    #проверяем админ ли залогинен или нет
    #$test= Dumper \%in;
    my $test= Dumper \%in;

    $debug->setMsg($test);
    my $data = Models::Utilits::Date->new();



    my $admin= Models::Performers::Admin->new();
    #$admin->add( 'admin','admin','admin@mail.ru');

    $data->{'pageparam'}='Login';
    if($admin->isLogin())
    {
        #переходим на главную страницу админа 
        $data->{'pageparam'}='ListAdmin'; 
    }
    elsif($in{'login'} )
    {
         my $err=undef;
        (
            ($in{'email'}) && ($in{'pass'} )

            &&(
                ($admin->login($in{'email'},$in{'pass'}) )
                 || ( $err=1 )
            )
        )
        ||( $err=2 );
        
         if($err)
        {
            $data->{'warnings'}=$err;
        }
        else
        {
            $data->{'redirect'}=Config::Config->getBaseUrl().'admin';
        }
        #print 'good login'; 
    }

    #print 'eee';

    #$admin->login($in{'mail'},$in{'pass'});

}



1;
