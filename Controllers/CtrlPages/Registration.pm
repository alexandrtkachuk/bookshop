package Controllers::CtrlPages::Registration;

use warnings;
use strict;

use Config::Config;

use Data::Dumper;
use Models::Utilits::Date;
use Models::Performers::User;
my $debug = Models::Utilits::Debug->new();

use vars qw(%in);
use Email::Valid;
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


    my $user= Models::Performers::User->new();
    #$admin->add( 'admin','admin','admin@mail.ru');

    
    if($user->isLogin())
    {
        #переходим на главную страницу админа 
        $data->{'redirect'}=Config::Config->getBaseUrl();

    }

    
    if($in{'registration'})
    {
            
        my $err=undef;
        my $data = Models::Utilits::Date->new();
        my $user= Models::Performers::User->new();

        (
            ($in{'email'}) && 
            ($in{'pass'} && Email::Valid->address($in{'email'})  ) &&
            ($in{'pass2'}) &&
            ($in{'name'}) &&
            ($in{'pass'} eq $in{'pass2'})
            &&
            ( $user->add( $in{'name'},$in{'pass'},$in{'email'})  )
        ) || ( $err = 2);
        

        if($err)
        {
            $data->{'warnings'}=$err;
        }
        else
        {
            $data->{'warnings'}=5;
            $data->{'redirect'}=Config::Config->getBaseUrl();
        }

    } 
        
    
    
    

   return 1;

}



1;
