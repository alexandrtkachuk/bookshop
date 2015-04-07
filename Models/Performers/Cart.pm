package Models::Performers::Cart;

use warnings;
use strict;



use Models::Utilits::Debug;
use Data::Dumper;
use Models::Utilits::Date;
use Models::Interfaces::Sql;
use Config::Config;

use Models::Utilits::Sessionme;
my $session =  Models::Utilits::Sessionme->new();

my $debug = Models::Utilits::Debug->new();
my $data = Models::Utilits::Date->new();

#$debug->setMsg(md5('test'));

#
#проверяем если корзина есть
#то ее модифицируем или добавляем 
#если нет то дописываем
#
#при удаление все переносим в таблицу заказов  
#


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
    my ($self,$iduser,$idbook,$count)=@_;
    my @arr= ( 'count' );
    $self->{'sql'}->select(\@arr);

    $self->{'sql'}->setTable('shop_book2user');
    $self->{'sql'}->where('idBook',$idbook);
    $self->{'sql'}->where('idUser',$iduser);
    unless($self->{'sql'}->execute())
    {
        $debug->setMsg( $self->{'sql'}->getError()); 
        return 0;

    }

    if($self->{'sql'}->getRows())
    {
        #$data->{'warnings'}=3;
        #return 0; #record exists 
       $self->upadte($iduser,$idbook,$count);

        return 1;
    }
    

        
    my %hash=('idBook'=>$idbook, 
        'idUser'=>$iduser,
        'count'=>$count
    );
    
    $self->{'sql'}->insert(\%hash);
    unless($self->{'sql'}->execute())
    {
       # print $self->{'sql'}->getError();

       return 0;
    }


    return 1;
    

}

sub delete
{

    my ($self,$iduser,$idbook)=@_;

    if($idbook )
    {
        $self->{'sql'}->delete();

        $self->{'sql'}->setTable('shop_book2user');
        $self->{'sql'}->where('idBook',$idbook);
        $self->{'sql'}->where('idUser',$iduser);
        unless($self->{'sql'}->execute())
        {
            $debug->setMsg( $self->{'sql'}->getError()); 
            return 0;

        }

    }



    return 1;

}

sub upadte 
{
    my ($self,$iduser,$idbook,$count)=@_;

    my %hash=('idBook'=>$idbook, 
        'idUser'=>$iduser,
        'count'=>$count
    );
    
    $self->{'sql'}->update(\%hash);
    $self->{'sql'}->where('idBook',$idbook);
    $self->{'sql'}->where('idUser',$iduser);

    unless($self->{'sql'}->execute())
    {
       # print $self->{'sql'}->getError(); 
       return 0;
    }

    #print $self->{'sql'}->getSql();
    return 1;


}

sub get
{
    my ($self,$iduser)=@_;
    my @arr= ( 'count', 'idBook' );
    $self->{'sql'}->select(\@arr);

    $self->{'sql'}->setTable('shop_book2user');
    $self->{'sql'}->where('idUser',$iduser);
    unless($self->{'sql'}->execute())
    {
        $debug->setMsg( $self->{'sql'}->getError()); 
        return 0;

    }

   unless($self->{'sql'}->getRows())
    {
        #$data->{'warnings'}=3;
        return 0;

    }

    return $self->{'sql'}->getResult();

} 



1;
