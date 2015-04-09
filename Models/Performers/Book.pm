package Models::Performers::Book;

use warnings;
use strict;


use Config::Config;
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

    my ($self,
        $title,
        $price,
        $fname,
        $info,
        $refauthors,
        $refgenre )=@_;

    #####################
    (
        ($title) &&
        ($price) &&
        ($fname)  &&
        ($info) &&
        ($refauthors) &&
        ($refgenre)
    ) || ( return 0 );

$debug->setMsg( Dumper $refauthors );

    my %hash=(
        'title'=>$title,
        'price'=>$price,
        'image'=>$fname,
        'info'=>$info
    );
    
    $self->{'sql'}->insert(\%hash);
    $self->{'sql'}->setTable('shop_books');

    unless($self->{'sql'}->execute())
    { 
        $debug->setMsg( $self->{'sql'}->getError()); 
        return 0;
    }
    
   my $lastId =  $self->{'sql'}->getLastId();

   # print 'last id='.$self->{'sql'}->getLastId()."\n";


    ###add to book2author####
    #########################
    
    $self->{'sql'}->setTable('shop_book2author');
    for(@$refauthors)
    {   
         my %hash2 =
        (
            'idbook'=> $lastId,
            'idauthor'=>$_
        );
$debug->setMsg( $hash2{'idauthor'} );
        $self->{'sql'}->insert(\%hash2);
        
        unless($self->{'sql'}->execute())
        { 
            $debug->setMsg( $self->{'sql'}->getError()); 
            return 0;
        }
    }

    ###add to book2genge#####
    #########################
    
    $self->{'sql'}->setTable('shop_book2genre');
    for(@$refgenre)
    {   
        my %hash2 =
        (
            'idbook'=> $lastId,
            'idgenre'=>$_
        );

        $self->{'sql'}->insert(\%hash2);
        
        unless($self->{'sql'}->execute())
        { 
            $debug->setMsg( $self->{'sql'}->getError()); 
            return 0;
        }
    }


return $title;

}


sub getAll
{
    my ($self,$forW)=@_;
   

    $self->{'sql'}->setTable('shop_book2author , shop_author');
    $self->{'sql'}->setDISTINCT(1);


    $self->{'sql'}->GROUP_CONCAT('shop_author.name','idauthor');
    $self->{'sql'}->where('shop_book2author.idbook = shop_books.id');
    $self->{'sql'}->where('shop_book2author.idauthor = shop_author.id');

    

    my $authors ='('.$self->{'sql'}->getSql().') as authors ';
    
    ######genre
    $self->{'sql'}->setTable('shop_book2genre , shop_genre');
    $self->{'sql'}->setDISTINCT(1);


    $self->{'sql'}->GROUP_CONCAT('shop_genre.name','idgenre');
    $self->{'sql'}->where('shop_book2genre.idbook = shop_books.id');
    $self->{'sql'}->where('shop_book2genre.idgenre = shop_genre.id');

    my $genres  ='('.$self->{'sql'}->getSql().')  as genres';
    

    #########
    $self->{'sql'}->setTable('shop_books,shop_book2author, shop_book2genre');
    
    $self->{'sql'}->setDISTINCT(1);

    my @arr= ( 'shop_books.id','shop_books.title','price', 'info', 'image', 
        $authors , $genres );
    $self->{'sql'}->select(\@arr);
    

    if($forW)
    {
        $self->{'sql'}->where($forW->{'value'}, $forW->{'var'});
    }


    unless($self->{'sql'}->execute())
    {
        $debug->setMsg( $self->{'sql'}->getError()); 
        return 0;
    }
    

    my $res = $self->{'sql'}->getResult(); 
    #print $self->{'sql'}->getSql();
    return $res;
    #return $self->{'sql'}->getSql();
}

sub getForGenre
{
    my ($self,$idgenre)=@_;
    unless( $idgenre)
    {
        return 0; 
    }
    
    my %hash = 
    (
        'value'=> 'shop_book2genre.idBook =id AND idgenre',
        'var' => $idgenre
    ); 

    return  $self->getAll(\%hash);

}

sub getForAuthor
{
    my ($self,$idauthor)=@_;
    unless( $idauthor)
    {
        return 0; 
    }
    
    my %hash = 
    (
        'value'=> 'shop_book2author.idBook =id AND idauthor',
        'var' => $idauthor
    ); 

    return  $self->getAll(\%hash);

}


sub delete
{
    my ($self,$id)=@_;

    return 0;
}


1;
