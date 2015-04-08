package Models::Performers::Order;

use warnings;
use strict;



use Models::Utilits::Debug;
use Data::Dumper;
use Models::Utilits::Date;
use Models::Interfaces::Sql;
use Config::Config;

my $debug = Models::Utilits::Debug->new();
my $data = Models::Utilits::Date->new();

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
        }   
        ,$class);

    return $self;

}


sub add
{
    my ($self,$iduser,$payment,$refcart, $userSele)=@_;
    
    unless($iduser &&  $payment && $refcart && $userSele )
    {
        return 0;
    }
     
    my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime();
    $year+=1900;
    
    
    my %hash=('idUser'=>$iduser,
        'idPayment'=>$payment,
        'orderDate'=>"$year-$mon-$mday $hour:$min:$sec"
    );

    $self->{'sql'}->setTable('shop_orders');
    $self->{'sql'}->insert(\%hash);

    unless($self->{'sql'}->execute())
    {       
        $debug->setmsg( $self->{'sql'}->geterror()); 
        return 0;
    }
    

    


    return 1;

}


1;
