package Models::Performers::Payment;

use warnings;
use strict;

use Models::Utilits::Debug;

my $debug = Models::Utilits::Debug->new();
my $data = Models::Utilits::Date->new();

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
            'sql'=>$sql
        }   
        ,$class);

    return $self;

}



sub add
{
   my ($self,$name)=@_;

   unless($name)
   {
        return 0;
   }
    
    my %hash=('name'=>$name);
    
    $self->{'sql'}->setTable('shop_payment');

    $self->{'sql'}->insert(\%hash);
    unless($self->{'sql'}->execute())
    {
       $debug->setMsg($self->{'sql'}->getError());

       return 0;
    }


   return 1;
}

sub update
{

    my ($self,$id)=@_;

   unless($id)
   {
        return 0;
   }
    
   return 1;


}

sub get
{
   my ($self)=@_;

    $self->{'sql'}->setTable('shop_payment');

    my @arr= ( 'name', 'id' );
    $self->{'sql'}->select(\@arr);
    
    unless($self->{'sql'}->execute())
    {
       $debug->setMsg($self->{'sql'}->getError());

       return 0;
    }
  
    return $self->{'sql'}->getResult();

}

sub getForId
{
    my ($self,$id)=@_;
    
    unless($id)
    {
        return 0;
    }

    $self->{'sql'}->setTable('shop_payment');
    

    my @arr= ( 'name', 'id' );
    $self->{'sql'}->select(\@arr);
    $self->{'sql'}->where('id',$id);
    unless($self->{'sql'}->execute())
    {
       $debug->setMsg($self->{'sql'}->getError());

       return 0;
    }
  
    return $self->{'sql'}->getResult();


}

1;
