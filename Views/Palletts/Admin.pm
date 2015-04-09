package Views::Palletts::Admin;


use warnings;
use strict;


#три строчки которые делают наследие 
use vars qw(@ISA); 
our @ISA = qw(Views::Palletts::Index);
require Views::Palletts::Index;
use Config::Config;
my $data = Models::Utilits::Date->new();
use Models::Performers::Order;
use CGI;
sub createHash
{
    
    my ($self)=@_;

    $self->{'title'}='Админка';
    $self->{'baseurl'}=Config::Config->getBaseUrl() ;
    $self->{'getHeader'}=$self->loadTemplate('Header');
    $self->{'getFooter'}=$self->loadTemplate('Footer');
    if($data->{'pageparam'} eq 'ListAdmin' ){
        $self->{'getContent'}=$self->loadTemplate($data->{'pageparam'});
    }
    else
    {
        
        my $fun = $data->{'pageparam'};
        $self->{'getContent'}=$self->$fun();
            }
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

    return $mess;

}


sub listorder
{

    my $order= Models::Performers::Order->new();
    
    my $ref = $order->getAll();

    my $str ='';
    
    my $q = CGI->new;   
    for(@$ref)
    {
        #$str.=$q->p($_->{'id'}.'----'.$_->{'payment'}); 
    } 

    #return 1;
    return $str;
}



1;
