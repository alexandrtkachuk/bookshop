package Controllers::CtrlPages::Login;

use warnings;
use strict;

use Config::Config;



use vars qw(%in);
use Models::Utilits::Email::Valid;
use CGI qw(:cgi-lib :escapeHTML :unescapeHTML);

ReadParse();

use Data::Dumper;
use Models::Utilits::Date;
use Models::Performers::User;
my $debug = Models::Utilits::Debug->new();






sub new
{

    my $class = ref($_[0])||$_[0];
    return bless({      },$class);
}

sub go
{



    if($in{'login'} )
    {
        my $err=undef;
        my $data = Models::Utilits::Date->new();
        my $user= Models::Performers::User->new();

        (
            ($in{'email'}) && ($in{'pass'} && Email::Valid->address($in{'email'}))

            &&(
                ($user->login($in{'email'},$in{'pass'}) )
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
            if ($user->getRole())
            {
                $data->{'redirect'}=Config::Config->getBaseUrl();
            }
            else
            {
                #$data->{'redirect'}=Config::Config->getBaseUrl().'admin';
                $data->{'redirect'}=Config::Config->getBaseUrl();
            }
        }

    }
    
    
    return 1;
}

1;
