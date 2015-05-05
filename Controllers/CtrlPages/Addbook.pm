package Controllers::CtrlPages::Addbook;

use warnings;
use strict;

use Config::Config;
use Models::Performers::Book;
use Data::Dumper;
use Models::Utilits::Date;
use Models::Performers::Admin;
my $debug = Models::Utilits::Debug->new();

use vars qw(%in);
use Email::Valid;
use CGI qw(:cgi-lib :escapeHTML :unescapeHTML);
use Encode;
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
        
        #my @authors=('1','2','3'); 
        #my @authors=split /;/, '1;4;3;' ;
        #    my $str = encode('utf8',$in{'author'});
        my @authors=split (";\0", $in{'author'}) ;

        my @genres=split /;\0/, $in{'genre'} ;
        $debug->setMsg( Dumper @authors );
        $debug->setMsg( '##################' );
        
         $debug->setMsg( $in{'author'});
         $debug->setMsg( '##################' );

        $file=~m/^.*(\\|\/)(.*)/; # strip the remote path and keep the filename    
        eval 
        {
            open( my $hf, ">$tdir/Resources/img/$file") or  (
                ($debug->setMsg( 'no open file'. ">$tdir/Resources/img/$file")) &&
                (return 0 )
            )  ;
            while(<$file>)
            {
                print $hf $_;
            }
        };
        if($@)
        {
            $debug->setMsg( $@);
            return 0;
        }
        
         my $book =  Models::Performers::Book->new();
        
         unless($book->add( $in{'title'},$in{'price'},$in{'file'},$in{'info'},\@authors, \@genres))
        {

            $data->{'warnings'}=4;
            return 0;
        }

        $data->{'warnings'}=5;


    }

return 1;    

}


1;
