package Models::Utilits::Date;
use warnings;
use strict;



my $self;
#конструктор
sub new
{
    
    
    my $class = ref($_[0])||$_[0];
    $self||=bless({
            'err' =>{},
            'nextpage'=>'',#следующая страница
            'numpage'=>undef,
            'pageparam'=>undef,#парам для страницы
            'warings'=>undef, #предупреждения
            'redirect'=>undef,
            'db'=>{}
        },$class);

    return $self;
}



sub set
{
    my ($self,$name,$value)=@_;
    $self->{$name}=$value;
    return 1;
}

sub get
{   
    my ($self,$name)=@_;
    return $self->{$name};
}


1;