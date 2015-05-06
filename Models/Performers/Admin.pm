package Models::Performers::Admin;

use warnings;
use strict;

use vars qw(@ISA); 
our @ISA = qw(Models::Performers::User);
require Models::Performers::User;

use Models::Utilits::Debug;

my $debug = Models::Utilits::Debug->new();


my $self;


sub new
{   
    #my $self;
    
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


sub getAllUsers
{
    my ($self) = @_;
    
    $self->{'sql'}->select(['id', 'name',
                '(select sale from shop_sale2user where id=idUser ) as sale']);

    $self->{'sql'}->setTable('shop_users');
    #$self->{'sql'}->where('idUser', $self->{'id'} );
    
    unless($self->{'sql'}->execute())
    {
        $debug->setMsg( $self->{'sql'}->getError()); 
        return 1;
    }

    unless( $self->{'sql'}->getRows())
    {
            return 2; 
    }

    my $res = $self->{'sql'}->getResult(); 
    return $res; 
}

1;
