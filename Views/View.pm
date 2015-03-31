package Views::View;
#User7
use warnings;
use strict;

use Models::Utilits::Date;
use Models::Utilits::Debug;
use Models::Utilits::File;
use Data::Dumper;
use Models::Utilits::UseClass;
$|=1;

my $date = Models::Utilits::Date->new();
sub new
{
    my $class = ref($_[0])||$_[0];
    return bless({'pallett'=>undef },$class);
}


sub go()
{
    my ($self,$tdir)=@_;
    #print "Content-type: text/html; encoding='utf-8'\n\n";
    my $templete=$tdir.'Resources/html/'.$date->{'nextpage'}.'.html';
    #print $templete;
    my $html=$self->loadTemplate($templete);

    if($html)
    {
        $self->{'pallett'}=Models::Utilits::UseClass->_getCls('Views/Palletts/',
            $date->{'nextpage'}
            ,undef );
        
        $html=$self->ReplaceF($html);
        $html=$self->ReplaceH($html);
        
        print $html; 
    }
    else
    {   
        $date->{'nextpage'}='Error';
        #$self->go($tdir);
        #print "no file";
    }
}

sub loadTemplate
{
    my($self,$filename)=@_;
    my $file = Models::Utilits::File->new();
    my $html = $file->getFile($filename); 
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
