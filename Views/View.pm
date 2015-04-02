package Views::View;
#User7
use warnings;
use strict;

use Models::Utilits::Date;
use Models::Utilits::Debug;
use Models::Utilits::File;
use Data::Dumper;
use Models::Utilits::UseClass;
use Config::Config;

use CGI qw(:cgi-lib :escapeHTML :unescapeHTML);
#use CGI::Carp qw(fatalsToBrowser); # позволит выводить ошибки в браузер
use Models::Utilits::Sessionme;

$|=1;

#my $date = Models::Utilits::Date->new();
sub new
{
    my $class = ref($_[0])||$_[0];
    return bless({
            'pallett'=>undef ,
            'data' => Models::Utilits::Date->new()
        },$class);
}


sub go()
{
    my ($self,$tdir)=@_;

    my $cgi = CGI->new;
    my $session =  Models::Utilits::Sessionme->new($cgi);

    my $cookie = $cgi->cookie(CGISESSID => $session->getId());
    
    if($self->{'data'}->{'redirect'} )
    {
        print $cgi->redirect($self->{'data'}->{'redirect'} );
    } 
    
    
    print $cgi->header( -cookie=>$cookie, -charset=>'utf-8');

    #print "Content-type: text/html; encoding='utf-8'\n\n";
    #my $templete=$tdir.'Resources/html/'.$self->{'data'}->{'nextpage'}.'.html';
    #print $templete;
    my $html=$self->loadTemplate( $self->{'data'}->{'nextpage'} );

    if($html)
    {
        $self->{'pallett'}=Models::Utilits::UseClass->_getCls('Views/Palletts/',
            $self->{'data'}->{'nextpage'}
            ,undef );
        
        
        $html=$self->ReplaceH($html);
        $html=$self->ReplaceF($html);
        
        print $html; 
    }
    else
    {   
        $self->{'data'}->{'nextpage'}='Error';
        #$self->go($tdir);
        #print "no file";
    }
}

sub loadTemplate
{
    my($self,$filename)=@_;
    my $tdir = Config::Config->getDir();
    my $fullpath= $tdir.'/Resources/html/'.$filename.'.html';
    #print $fullpath; 
    my $file = Models::Utilits::File->new();
    my $html = $file->getFile($fullpath); 
    return $html;


}


sub ReplaceH
{
    my($self,$text)=@_;

    unless( $self->{'pallett'})
    {
        return $text; #'no pallet';
    } 
    
    $self->{'pallett'}->createHash();


    $text=~s/%%(\w+)%%/$self->{'pallett'}->{$1}/ge;
    
    #для поодержки вложеностей 
    $text=~s/%%(\w+)%%/$self->{'pallett'}->{$1}/ge;
    
    return $text;

}


sub ReplaceF
{
    my($self,$text)=@_;

    unless( $self->{'pallett'})
    {
        return $text; #'no pallet';
    } 
    #print $self->{'pallett'}->viewdebug();
    #$text=~s/##(\w+)##/$self->$1()/ge;
    $text=~s/##(\w+)##/$self->{'pallett'}->$1()/ge;
    return $text;

}

1;
