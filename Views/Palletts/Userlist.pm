package Views::Palletts::Userlist;


use warnings;
use strict;


#три строчки которые делают наследие 
use vars qw(@ISA); 
our @ISA = qw(Views::Palletts::Admin);
require Views::Palletts::Admin;

use Models::Performers::Admin;
use Data::Dumper;

sub userlist
{
    my ($self)=@_;
    my $admin =  Models::Performers::Admin->new();
    my $ref = $admin->getAllUsers();
    #print  '<pre>',Dumper($ref),'</pre>';
    
    my $str =''; 
    my $tdES = $self->loadTemplate('helper/tdEditSale');
    my $tdL = $self->loadTemplate('helper/tdLink');
    my $tr = $self->loadTemplate('helper/tr');
    my $td = $self->loadTemplate('helper/td');
    my $th = $self->loadTemplate('helper/th');
    my $thead = $self->loadTemplate('helper/thead');
    
    my $temp='';
    #$temp.=$self->Replace($th,{'value'=>'№'});
    $temp.=$self->Replace($th,{'value'=>'id User'});
    $temp.=$self->Replace($th,{'value'=>'Имя'});
    $temp.=$self->Replace($th,{'value'=>'Скидка:'});
    $temp.=$self->Replace($th,{'value'=>'Изменить скидку'});
    
    $str .= $self->Replace($thead,{'value'=>$temp}); 
    
    
    for(@$ref)
    {
        my $temp ='';
        $temp.=$self->Replace($td,{'value'=>$_->{'id'} });
        $temp.=$self->Replace($tdL,{'value'=>$_->{'name'} ,
                                    'id'=>$_->{'id'}});
        $temp.=$self->Replace($td,{'value'=>($_->{'sale'}*1).'%' });
        
        $temp.=$self->Replace($tdES,{'value'=>'Изменить',
                                    'id'=>$_->{'id'},
                                    'sale'=>$_->{'sale'}*1
                                    });
        $str.=$self->Replace($tr,{'value'=>$temp});
        
    }
    
    return $str;
}

1;