package Views::Palletts::Admin;


use warnings;
use strict;


#три строчки которые делают наследие 
use vars qw(@ISA); 
our @ISA = qw(Views::Palletts::Index);
require Views::Palletts::Index;


sub createHash
{
    my $date = Models::Utilits::Date->new();

    my ($self)=@_;
    $self->{'title'}='Админка';
    $self->{'getHeader'}=$self->loadTemplate('Header');
    $self->{'getFooter'}=$self->loadTemplate('Footer');
}



1;
