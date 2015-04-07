package Models::Utilits::Lang;

use warnings;
use strict;

use Models::Utilits::Sessionme;
my $session =  Models::Utilits::Sessionme->new();



my $self;


sub new
{   

       my $class = ref($_[0])||$_[0];
        my $lang='ru';

        if($session->getParam('lang'))
        {
           $lang=$session->getParam('lang');
 
        }

    $self||=bless(
        {   
            'lang'=>$lang
            
        }   
        ,$class);

    return $self;

}


sub get
{
    my ($self)=@_;
    
    return $self->{'lang'};
}


sub set
{
    my ($self,$value)=@_;
    
    unless($value)
    {
        return 0;
    }

    $session->setParam('lang',$value);
    
    return $value;
}






1;
