package Views::Palletts::Booklist;


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
use Data::Dumper;
use Models::Performers::Book;

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



sub booklist
{
    my ($self)=@_;
    my $str ='';
    my $book =  Models::Performers::Book->new();
    my $res=$book->getAll();
    
    
    #$str = $res[0]->id;
    
    my $tr = $self->loadTemplate('helper/tr');
    my $td = $self->loadTemplate('helper/td');
    my $tdE = $self->loadTemplate('helper/tdEditPrice');
    for(@$res)
    {
        my $temp ='';
        $temp.=$self->Replace($td,{'value'=>$_->{'id'} });
        $temp.=$self->Replace($td,{'value'=>$_->{'title'}});
        $temp.=$self->Replace($td,{'value'=>$_->{'price'} });
        $temp.=$self->Replace($tdE,{'value'=>'edit price',
                                    'id'=>$_->{'id'},
                                    'price'=>$_->{'price'}});
        
        $str.= $self->Replace($tr,{'value'=>$temp});
        
    }
    
    return $str;
}





1;