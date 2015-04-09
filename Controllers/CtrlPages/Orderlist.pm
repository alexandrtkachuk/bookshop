package Controllers::CtrlPages::Api;

use warnings;
use strict;

use Config::Config;

sub new
{

    my $class = ref($_[0])||$_[0];
    return bless({      },$class);
}



sub go
{
    my $data = Models::Utilits::Date->new();

    my ($self)=@_;


    my $admin= Models::Performers::Admin->new();
    #$admin->add( 'admin','admin','admin@mail.ru');

    
    unless($admin->isLogin())
    {
        #переходим на главную страницу админа 
        $data->{'redirect'}=Config::Config->getBaseUrl().'login';

    }
        
    
    
    

   return 1;

}





1;
