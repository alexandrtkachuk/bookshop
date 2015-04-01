package Models::Performers::User;

use warnings;
use strict;



use Models::Utilits::Debug;
use Data::Dumper;
use Models::Utilits::Date;
use Models::Interfaces::Sql;
use Config::Config;
use Digest::MD5 qw(md5 md5_hex md5_base64) ;
use Models::Utilits::Sessionme;
my $session =  Models::Utilits::Sessionme->new();

my $debug = Models::Utilits::Debug->new();


#$debug->setMsg(md5('test'));


my $self;


sub new
{   

    my $sql =  Models::Interfaces::Sql->new(
        Config::Config::DBUSER,
        Config::Config::DBHOST,
        Config::Config::DBNAME,
        Config::Config::DBPASS);
    $self || $sql->connect();
    my $class = ref($_[0])||$_[0];

    $self||=bless(
        {   
            'sql'=>$sql,
            'name'=>undef,
            'emain'=>undef,
            'id'=>undef 
        }   
        ,$class);

    return $self;

}

#add user
sub add
{

    my ($self,$name,$pass,$email)=@_;
    




    $debug->setMsg("add user: name: $name \n
        pass: $pass \n emai: $email ");
    
    my %hash=('key1'=>2, 'key2'=>'te st');
    
    $self->{'sql'}->insert(\%hash);


    return 1;

}

1;
