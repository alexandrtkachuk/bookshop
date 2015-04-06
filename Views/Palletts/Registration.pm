package Views::Palletts::Registration;


use warnings;
use strict;


#три строчки которые делают наследие 
use vars qw(@ISA); 
our @ISA = qw(Views::Palletts::Index);
require Views::Palletts::Index;
use Config::Config;
my $data = Models::Utilits::Date->new();

sub createHash
{
    
    my ($self)=@_;

    $self->{'title'}='Registration';
    $self->{'baseurl'}=Config::Config->getBaseUrl() ;
    $self->{'getHeader'}=$self->loadTemplate('Header');
    $self->{'getFooter'}=$self->loadTemplate('Footer');
        #print $data->{'pageparam'};
}



sub warings
{
    my $mess='';

    
    if($data->{'warnings'}==1)
    {
         $mess = 'неверный логин или пароль при входе';
    }
    elsif($data->{'warnings'}==2 )
    {
        $mess = 'не все поля заполнены в форме';
    }
    elsif($data->{'warnings'}==5 )
    {
        $mess = 'Вы успешно зарегестрировались, можете <a href="'.Config::Config->getBaseUrl().'">
        авторизироваться</a>';
    }

    return $mess;

}

1;
