package Views::Palletts::Index;
use Models::Utilits::Debug;
use Data::Dumper;
use Models::Utilits::Date;
use Models::Interfaces::Sql;
use Config::Config;
use Views::View;


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

sub loadTemplate
{
    my($self,$filename)=@_;
    my $text = Views::View->loadTemplate($filename);
    return $text;
}

sub Replace
{
    my($self,$text,$ref)=@_; 
    $text=~s/%%(\w+)%%/$ref->{$1}/ge;
    return $text;

}

1;
