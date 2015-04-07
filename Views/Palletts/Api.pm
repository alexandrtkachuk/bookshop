package Views::Palletts::Api;


use warnings;
use strict;
use JSON;
use Encode;

#три строчки которые делают наследие 
use vars qw(@ISA); 
our @ISA = qw(Views::Palletts::Index);
require Views::Palletts::Index;
use Config::Config;
my $data = Models::Utilits::Date->new();
use Models::Performers::Book;
use Models::Performers::User;
use Models::Utilits::Lang;
use Models::Utilits::File;
use XML::Simple qw(:strict);


sub createHash
{
    
    my ($self)=@_;

    $self->{'title'}='Api';
    #print $data->{'pageparam'};
}


sub  getOut
{
    my ($self)=@_;

    if($data->{'pageparam'} eq 'addauthor')
    {
        #return 'add author';
        return $self->getJSON();

    }
    elsif($data->{'pageparam'} eq 'addgenre' )
    {
        ##########################
        return $self->getJSON();

    }
    elsif($data->{'pageparam'} eq 'books' )
    {
        ##########################
        return $self->allbooks();

    }
    elsif($data->{'pageparam'} eq 'user')
    {
        return $self->user();
    }
    elsif($data->{'pageparam'} eq 'lang')
    {
        return $self->getLang();
    }


    

    return '';

}


sub getWarings
{
    
    unless($data->{'warnings'})
    {
        return '0';
    }

    return $data->{'warnings'};


} 


sub getJSON
{
   my %hash = 
    (
        'warings'=>getWarings(),
        'debug' =>'debug'
    );

    return  encode_json \%hash;
    return 'test';

}


sub allbooks
{
    my $book =  Models::Performers::Book->new();
    my $res=$book->getAll();
    my $str; 
    if($data->{'numpage'}) 
    {
         $str =  encode_json $$res[ $data->{'numpage'} - 1];
    }
    else
    {
         $str =  encode_json $res;
    }
    return  decode('utf8',$str);

}

sub user
{
    my $user= Models::Performers::User->new();
    my %hash = 
    (
        'name'=>$user->getName(),
        'id' =>$user->getId()
    );
    return  encode_json \%hash;
    #return 'user';
}

sub getLang
{

    my $lang = Models::Utilits::Lang->new();
    my $res;
    #$res= $lang->get();
    #print "\n";
    my $tdir = Config::Config->getDir();;
    my $fullpath= $tdir.'/Resources/langs/ru.strings';
    #print $fullpath; 
    my $file = Models::Utilits::File->new();
    my $xml = $file->getFile($fullpath); 

    #print $xml;

    if($xml)
    { 
        my $ref = XMLin($fullpath, forcearray => 1, keyattr => ['ISTRING'] );
        $res= encode_json $ref;
    }
    return  decode('utf8',$res);
    

}


1;
