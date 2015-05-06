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
my $debug = Models::Utilits::Debug->new();
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
    # $debug->setMsg('numpage='.$data->{'numpage'});
    $debug->setMsg('iduser='.$data->{'iduser'});
    my $ref = $order->getAll($data->{'iduser'});

        my $str ='';
        my $text=$self->loadTemplate('helper/col-md-2'); 
        my $tdE = $self->loadTemplate('helper/tdSendByu');
        my $tdL = $self->loadTemplate('helper/tdLink');
        my $tr = $self->loadTemplate('helper/tr');
        my $td = $self->loadTemplate('helper/td');
        my $th = $self->loadTemplate('helper/th');
        my $thead = $self->loadTemplate('helper/thead');
        
        my $temp='';
        $temp.=$self->Replace($th,{'value'=>'№'});
        $temp.=$self->Replace($th,{'value'=>'id User'});
        $temp.=$self->Replace($th,{'value'=>'Система оплаты'});
        $temp.=$self->Replace($th,{'value'=>'Дата заказа'});
        $temp.=$self->Replace($th,{'value'=>'Сумма'});
        $temp.=$self->Replace($th,{'value'=>'Статус'});
        $temp.=$self->Replace($th,{'value'=>'изменить статус'});
        
        $str .= $self->Replace($thead,{'value'=>$temp}); 
        
        
    for(@$ref)
    {
        my $temp ='';
        $temp.=$self->Replace($td,{'value'=>$_->{'id'} });
        $temp.=$self->Replace($tdL,{'value'=>$_->{'idUser'} ,
                                    'id'=>$_->{'idUser'}});
        $temp.=$self->Replace($td,{'value'=>$_->{'payment'}});
        
        $temp.=$self->Replace($td,{'value'=>$_->{'orderDate'}});
        $temp.=$self->Replace($td,{'value'=>sprintf("%.2f", $_->{'sum'})});
       
       
       if ($_->{'status'}) {
             $temp.=$self->Replace($td,{'value'=>'Оплаченно'});
            $temp.=$self->Replace($td,{'value'=>'Оплаченно'});
       }
       else
       {
            $temp.=$self->Replace($td,{'value'=>'не оплаченно'});
            $temp.=$self->Replace($tdE,{'value'=>'Оплаченно',
                                    'id'=>$_->{'id'},});
       }
       
        
        
        $str.=$self->Replace($tr,{'value'=>$temp});
    } 

    #return 1;
    return $str;
}



1;
