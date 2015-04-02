package Controllers::CtrlPages::Admin;

use warnings;
use strict;




use vars qw(%in);
use Models::Utilits::Email::Valid;
use CGI qw(:cgi-lib :escapeHTML :unescapeHTML);

ReadParse();

use Data::Dumper;

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




    my $admin= Models::Performers::Admin->new();
    #$admin->add( 'admin','admin','admin@mail.ru');
    (
        ($in{'email'}) && ($in{'pass'} )

        &&(
            ($admin->login($in{'email'},$in{'pass'}) )
            || ( print 'err pass' )
        )
    )
    ||( print 'enter pass and mail' ); 
    #$admin->login($in{'mail'},$in{'pass'});

}



1;
