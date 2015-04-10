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
my ($self)=@_;
    my $order= Models::Performers::Order->new();
    
    my $ref = $order->getAll();

    my $str ='';
     my $text=$self->loadTemplate('helper/col-md-2'); 
 
        $str.=$self->Replace($text,{'value'=>'№'});
        $str.=$self->Replace($text,{'value'=>'id User'});
        $str.=$self->Replace($text,{'value'=>'Система оплаты'});
        $str.=$self->Replace($text,{'value'=>'Дата заказа'});
        $str.=$self->Replace($text,{'value'=>'Сумма'});
        $str.=$self->Replace($text,{'value'=>'Статус'});
             

    for(@$ref)
    {
        $str.=$self->Replace($text,{'value'=>$_->{'id'} });
        $str.=$self->Replace($text,{'value'=>$_->{'idUser'}});
        $str.=$self->Replace($text,{'value'=>$_->{'payment'}});
        
        $str.=$self->Replace($text,{'value'=>$_->{'orderDate'}});
        $str.=$self->Replace($text,{'value'=>$_->{'sum'}});
        $str.=$self->Replace($text,{'value'=>$_->{'status'}});
    } 

    #return 1;
    return $str;
}



1;
