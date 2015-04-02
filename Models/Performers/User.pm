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
            'id'=>undef,
            'role'=>undef 
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
    
    my %hash=('name'=>'admin', 
        'pass'=>md5('admin'),
        'email'=>'admin@mail.ru',
        'role'=>0 # 0=admin , 1=user
    );
    
    #$self->{'sql'}->insert(\%hash);
    #$self->{'sql'}->setTable('shop_users');
    
    #unless($self->{'sql'}->execute())
    #{
        # print $self->{'sql'}->getError(); 
        #}
    

    return 1;

}


sub login
{

    my ($self,$email,$pass)=@_;

    my @arr= ( 'name', 'id' ,'role', 'email' );
    $self->{'sql'}->select(\@arr);
    $self->{'sql'}->setTable('shop_users');
    $self->{'sql'}->where('email',$email);
    $self->{'sql'}->where('pass',md5($pass));
    
    unless($self->{'sql'}->execute())
    {
        $debug->setMsg( $self->{'sql'}->getError()); 
        return 0;
    }
    else
    {
        my $res = $self->{'sql'}->getResult();
        print 'good'; 
        unless($self->{'sql'}->getRows())
        {
            return 0;
        }
         
        
        
    }
    
    return 1;
}


1;
