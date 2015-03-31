package Views::Palletts::Index;
#user7

use Models::Utilits::Debug;
use Data::Dumper;
use Models::Utilits::Date;
use Models::Interfaces::Sql;
use Config::Config;


sub new
{
    my $class = ref($_[0])||$_[0];
    return bless({  },$class);
}


#запускаеться когад нужно мунять на хеши
sub createHash
{
    my $date = Models::Utilits::Date->new();

    my ($self)=@_;
    $self->{'page'}=$date->{'nextpage'};
    $self->{'title'}='<a href="index">Главня</a>';
}


#пример функции которая в запуститься если в шаюлоне встретит ##viewdubug##
sub viewdebug
{
    
    my($self)=@_;   
    my $debug = Models::Utilits::Debug->new();
    my $d=$debug->getMsg();
    return  Dumper(\$d);
     
    
}




sub loginuser
{   
        return "";

}

sub AUTOLOAD
{
    return '';

}

1;
