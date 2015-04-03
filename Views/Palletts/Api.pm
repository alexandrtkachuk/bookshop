package Views::Palletts::Api;


use warnings;
use strict;
use JSON;


#три строчки которые делают наследие 
use vars qw(@ISA); 
our @ISA = qw(Views::Palletts::Index);
require Views::Palletts::Index;
use Config::Config;
my $data = Models::Utilits::Date->new();

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

1;
