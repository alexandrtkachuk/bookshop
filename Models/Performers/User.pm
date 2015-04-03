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
            'email'=>undef,
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
        pass: $pass \n email: $email ");
    
    my %hash=('name'=>$name, 
        'pass'=>md5($pass),
        'email'=>$email,
        'role'=>0 # 0=admin , 1=user
    );
    
    $self->{'sql'}->insert(\%hash);
    $self->{'sql'}->setTable('shop_users');
    
    unless($self->{'sql'}->execute())
    {
       # print $self->{'sql'}->getError(); 
       return 0;
    }
    

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
my $res = $self->{'sql'}->getResult();
#print 'good'; 
unless($self->{'sql'}->getRows())
{
    return 0;
}

$self->{'name'} = $res->[0]{'name'};
$self->{'email'} = $res->[0]{'email'};
$self->{'id'} = $res->[0]{'id'};
$self->{'role'} = $res->[0]{'role'};

##save to sessin
$session->setParam('email',$self->{'email'});
$session->setParam('name',$self->{'name'});
$session->setParam('id',$self->{'id'});
$session->setParam('role',$self->{'role'});

#print Dumper $self ;


return 1;
}


sub isLogin
{
    my ($self)=@_;

    #print 'mail='.$session->getParam('email').' id='.$session->getId();


    if($self->{'name'})
    {
        return 1;

    }


    if($session->getParam('email'))
    { 

        $self->{'email'} = $session->getParam('email');
        $self->{'id'} = $session->getParam('id');
        $self->{'name'} = $session->getParam('name');
        $self->{'role'} = $session->getParam('role');
        return 1;

    } 

    return 0;

}



sub logout
{
    $self->{'email'} = undef;
    $self->{'id'} = undef;
    $self->{'name'} = undef;
    $self->{'role'} = undef;
    $session->delete();

    return 1;

}


sub getName
{
    my ($self)=@_;

    return $self->{'name'};
}

sub getId
{
    my ($self)=@_;

    return $self->{'id'};
}

sub getEmail
{
    my ($self)=@_;

    return $self->{'email'};
}


sub getRole
{
    my ($self)=@_;

    return $self->{'role'};

}


1;
