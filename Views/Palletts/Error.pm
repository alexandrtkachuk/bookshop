package Views::Palletts::Error;
#user7

use vars qw(@ISA); 
our @ISA = qw(Views::Palletts::Index);
require Views::Palletts::Index;

use Models::Utilits::Debug;
use Data::Dumper;
use Models::Utilits::Date;



sub createHash
{
    my $date = Models::Utilits::Date->new();

    my ($self)=@_;
    $self->{'page'}=$date->{'nextpage'};

}






1;
