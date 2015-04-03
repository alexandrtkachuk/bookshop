package Models::Performers::Genre;

use warnings;
use strict;



use Models::Utilits::Debug;
use Data::Dumper;
use Models::Utilits::Date;
use Models::Interfaces::Sql;

my $self;
my $debug = Models::Utilits::Debug->new();
my $data = Models::Utilits::Date->new();

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
        $data->{'warnings'}=2;
        return 0;
    }

        
    my %hash=('name'=>$name);
    
    my @arr= ( 'name' );
    $self->{'sql'}->select(\@arr);

    $self->{'sql'}->setTable('shop_genre');
    $self->{'sql'}->where('name',$name);

    unless($self->{'sql'}->execute())
    {
        $debug->setMsg( $self->{'sql'}->getError()); 
        return 0;
    }

    if($self->{'sql'}->getRows())
    {
        $data->{'warnings'}=3;
        return 0; #record exists 
    }


    $self->{'sql'}->insert(\%hash);
    $self->{'sql'}->setTable('shop_genre');
    
    unless($self->{'sql'}->execute())
    { 
        $debug->setMsg( $self->{'sql'}->getError()); 
       return 0;
    }
    

    return 1;

}

sub getAll
{

    my ($self)=@_;

    my @arr= ( 'name' , 'id' );
    $self->{'sql'}->setTable('shop_genre');
    $self->{'sql'}->select(\@arr);
    unless($self->{'sql'}->execute())
    {
        $debug->setMsg( $self->{'sql'}->getError()); 
        return 0;
    }

    return $self->{'sql'}->getResult();
    



}

sub getId
{

    my ($self,$id)=@_;
    unless($id)
    {
        return 0;
    }

}






1;
