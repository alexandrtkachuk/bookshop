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

#use CGI;
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
    
    
    unless($admin->isLogin())
    {
        #переходим на главную страницу админа 
        $data->{'redirect'}=Config::Config->getBaseUrl().'login';

    }

    if($in{addbook}){
         $debug->setMsg( Dumper \%in );

        my $cgi = new CGI;
        my $dir = $cgi->param('dir');
        my $file = $cgi->param('file');

        my $tdir = Config::Config->getDir();
        ##################

        ############################

        
        (
            ($in{'title'})
            && ($in{'price'})
            && ($in{'author'})
            && ($in{'genre'})
            && ($in{'info'})
            && ($in{'file'})

        ) ||
        (     ($data->{'warnings'}=2)
            &&(return 0)   
        );
        
        
        $file=~m/^.*(\\|\/)(.*)/; # strip the remote path and keep the filename    
        eval 
        {
            open( my $hf, ">$tdir/Resources/img/$file") or  $debug->setMsg( 'no open file')  ;
            while(<$file>)
            {
                print $hf $_;
            }
        };
        if($@)
        {
            $debug->setMsg( $@);

        }



    }

return 1;    

}


1;
