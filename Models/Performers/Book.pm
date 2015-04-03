package Models::Performers::Book;

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

    my ($self,
        $title,
        $price,
        $fname,
        $info,
        $refauthors,
        $refgnre )=@_;

    #####################
    (
        ($title) &&
        ($price) &&
        ($fname)  &&
        ($info) &&
        ($refauthors) &&
        ($refgnre)
    ) || ( return 0 );



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
    

    ###add to book2author####
    #########################

    ###add to book2genge#####
    #########################

return 1;

}

1;
