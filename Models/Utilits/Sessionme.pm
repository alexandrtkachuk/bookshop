package Models::Utilits::Sessionme;
#user7
use CGI qw(:cgi-lib :escapeHTML :unescapeHTML);
use File::Basename;

use CGI::Session;
Config::Config;
use warnings;
use strict;



my $self;
my $tdir; 

sub new
{   
        
    
       my $class = ref($_[0])||$_[0];
         Config::Config->getDir();
       my $session;
    unless($self)
    {
        #print "create sses";
        #my $tdir= Config::Config->getDir(); 
       #print $tdir;
       $tdir=Config::Config->getDir();

        $session = new CGI::Session("driver:File",$_[1], {Directory=>'/tmp'});
       

        #print "create sses";
    }

    $self||=bless(
        {   
            'session'=>$session,
            'id'=>$session->id() 
        }   
        ,$class);

    return $self;

}


sub getId
{   
    my ($self)=@_;
    return $self->{'id'};
}

sub delete
{
    my ($self)=@_;

    $self->{'session'}->delete();
    return 1;
}

sub setParam($$)
{
    my ($self,$param,$value)=@_;

    $self->{'session'}->param($param,$value);
    
    #print $tdir;
    return 1;
    

}

sub getParam($)
{
    my ($self,$param)=@_;
    
    #print 'Get='.$tdir."\n";
    return $self->{'session'}->param($param);

}

sub DESTROY
{

}

1;

