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

    

    return 'test api';

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

1;
