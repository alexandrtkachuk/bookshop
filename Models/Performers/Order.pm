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
    my ($self,$iduser,$payment,$refcart, $userSale)=@_;
    
    unless($iduser &&  $payment && $refcart  )
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
        $debug->setMsg( $self->{'sql'}->getError()); 
        return 0;
    }
    
    my $idorder = $self->{'sql'}->getLastId();
    #################add to book2order###
    $self->{'sql'}->setTable('shop_order2book');
    
    my $sale = 0;

    if($userSale)
    {
        $sale=$userSale/100;
    }


    for(@$refcart)
    {
        my %hash = 
        (
            'idOrder'=>$idorder,
            'idBook'=>$_->{'id'},
            'count'=>$_->{'count'},
            'price'=>($_->{'price'}-($_->{'price'}*$sale))
        ); 

        $self->{'sql'}->insert(\%hash);

        unless($self->{'sql'}->execute())
        {       
            $debug->setMsg( $self->{'sql'}->getError()); 
            return 0;
        }


    } 

    #####order2status###########
    #
    my %hash2 = 
        (
            'idOrder'=>$idorder,
            'status'=>0,
        ); 
        
        $self->{'sql'}->setTable('shop_order2status');
        $self->{'sql'}->insert(\%hash2);

        unless($self->{'sql'}->execute())
        {       
            $debug->setMsg( $self->{'sql'}->getError()); 
            return 0;
        }


    return 1;

}

sub get
{
    my ($self,$iduser)=@_;
    


    unless($iduser)
    {
        return 0;
    }
    return $self->getAll($iduser);
    


}

sub getAll
{
    #get short info for orders (id, payment,price, status) 
    my ($self,$iduser)=@_;
    

    #select id , idUser,
    #(select name from shop_payment where idPayment =shop_payment.id ) , 
    #(select sum(price) from shop_order2book where idOrder = id) as sum 
    #from shop_orders ;
    
    my @pay = ('name');

    $self->{'sql'}->setTable('shop_payment');
    $self->{'sql'}->where('idPayment = shop_payment.id');
    $self->{'sql'}->select(\@pay);
    my $qPay = $self->{'sql'}->getSql();

    my @sum = ('sum(price)');
    $self->{'sql'}->setTable('shop_order2book');
    $self->{'sql'}->where('idOrder = id');
    $self->{'sql'}->select(\@sum);
    my $qSum = $self->{'sql'}->getSql();

    my @arr= ( 'id','idUser', 'status',
        "( $qSum ) as sum " , 
        "( $qPay ) as  payment " , 
        'orderDate' );
    $self->{'sql'}->select(\@arr);
    $self->{'sql'}->setTable('shop_orders , shop_order2status');
    $self->{'sql'}->where('idOrder = id' );
    if($iduser)
    {
        $self->{'sql'}->where('idUser' , $iduser );
    }

    $self->{'sql'}->OrederBy('id','DESC'); 
    unless($self->{'sql'}->execute())
    {
        $debug->setMsg( $self->{'sql'}->getError()); 
        return 0;

    }
    # $debug->setMsg( $self->{'sql'}->getSql());
   unless($self->{'sql'}->getRows())
    {
        #$data->{'warnings'}=3;
        return 0;

    }

    return $self->{'sql'}->getResult();




}

sub setSatus
{

}


sub getInfo
{
    my ($self,$idorder,$iduser)=@_;
    #select shop_order2book.price , title 
    #from shop_orders , shop_order2book , shop_books 
    #where shop_orders.id = idOrder AND idUser = 2 AND shop_books.id = idBook ;
    unless($idorder)
    {
        return 0;
    }
    my @arr = ('shop_order2book.price, title', 'shop_books.id' );
    $self->{'sql'}->setTable('shop_order2book,shop_orders, shop_books ');
    $self->{'sql'}->where('idOrder',$idorder);
    $self->{'sql'}->where(' shop_orders.id = idOrder ');
    $self->{'sql'}->where(' shop_books.id = idBook');
    if($iduser)
    {
    
            $self->{'sql'}->where('idUser',$iduser);
    }

    $self->{'sql'}->select(\@arr);
    
    unless($self->{'sql'}->execute())
    {
        $debug->setMsg( $self->{'sql'}->getError()); 
        return 0;

    }
    # $debug->setMsg( $self->{'sql'}->getSql());
    unless($self->{'sql'}->getRows())
    {
        #$data->{'warnings'}=3;
        return 0;

    }

    return $self->{'sql'}->getResult();


}

1;
