package Controllers::CtrlPages::Api;

use warnings;
use strict;

use Config::Config;

use Data::Dumper;
use Models::Utilits::Date;
use Models::Performers::Admin;
my $debug = Models::Utilits::Debug->new();
use JSON;
use Models::Utilits::Lang;
use Models::Validators::Varibles;
use vars qw(%in);
use Email::Valid;
use CGI qw(:cgi-lib :escapeHTML :unescapeHTML);
use Models::Performers::Cart;
use Models::Performers::Authors;
use Models::Performers::Genre;
use Models::Performers::Order;
use Models::Performers::Book;
use Models::Performers::Order;
ReadParse();
my $debug = Models::Utilits::Debug->new();
my $data = Models::Utilits::Date->new();
    
    
sub new
{

    my $class = ref($_[0])||$_[0];
    return bless({      },$class);
}

sub go
{

    my ($self) = @_;
    my $user = Models::Performers::User->new();

    if($in{'num'})
    {
        $data->{'numpage'}=$in{'num'};
    }

    ##сначала функции которые доступны всем пользовотелям затем только админу
    
    
    if( $data->{'pageparam'} eq 'books') 
    {
        return 1;
    }
    elsif($data->{'pageparam'} eq 'lang')
    {
      return 1; 
    }
    elsif($data->{'pageparam'} eq 'setlang')
    {
        $data->{'pageparam'} = 'warings';
        $self->setLang();
        return 1;
    }
    elsif($data->{'pageparam'} eq 'payment')
    {
      return 1; 
    }
    elsif($data->{'pageparam'} eq 'getauthors')
    {
      return 1; 
    }
    elsif($data->{'pageparam'} eq 'getgenres')
    {
      return 1; 
    }
    elsif($data->{'pageparam'} eq 'getbookforauthor')
    {
        if($in{'num'})
        {
            return 1; 
        }
    }
     elsif($data->{'pageparam'} eq 'getbookforgenre')
    {
       if($in{'num'})
        {
            return 1; 
        }

    }
    else
    {}

    ################FOR USER#################################
    unless($user->isLogin() )
    {
        $data->{'pageparam'} = undef;
        return 0;
    }
    
    if( $data->{'pageparam'} eq 'user') 
    {
        return 1;
    }
    elsif($data->{'pageparam'} eq 'addcart' )
    {
        
        $self->addCart();
        return 1;
    }
    elsif($data->{'pageparam'} eq 'getcart' )
    {
        
        return 1;
    }
    elsif($data->{'pageparam'} eq 'addorder' )
    {
        $data->{'pageparam'} = 'warings';
        $self->addOrder();
        
        return 1;
    }
    elsif($data->{'pageparam'} eq 'getorders' )
    {   
        return 1;
    }
    else{}
    

    ################FOR ADMIN#################################
    
    if(0)
    {
        #$data->{'pageparam'} = undef;
        #return 0;
    }   


    if( $data->{'pageparam'} eq 'addauthor') 
    {
        $self->addAuthor($in{'name'});

    }
    elsif($data->{'pageparam'} eq 'addgenre' )
    {
        $self->addGenre($in{'name'});
    }
    elsif($data->{'pageparam'} eq 'editprice')
    {
        $self->editPrice($in{'idbook'},$in{'price'});
        $data->{'pageparam'} = 'warings';
    }
    elsif($data->{'pageparam'} eq 'setstatus')
    {
        $self->setStatus($in{'id'});
        $data->{'pageparam'} = 'warings';
    }
    ##$data->{'pageparam'}

    return 0;

}


sub setStatus
{
    my ($self,$id)=@_;
    
    unless($id)
    {
        $data->{'warnings'}=6;
        return 0;
    }
    
    $debug->setMsg('id='.$id); 
    my $order= Models::Performers::Order->new();
    unless($order->setSatus($id))
    {
        $data->{'warnings'}=4;
        return 0;
    }
    
    return 1;
    
}

sub editPrice
{
    
   my ($self,$idBook,$price)=@_;
   
   $debug->setMsg('idbook='.$idBook);
   $debug->setMsg('price='.$price);
   unless(Models::Validators::Varibles->isNumeric2($price))
   {
        $data->{'warnings'}=3;
        return 0;
   }
   
   if($price<1)
   {
        $data->{'warnings'}=2;
        return 0;
   }
   
   my $book =  Models::Performers::Book->new();
   unless($book->editPrice($idBook,$price))
   {
        $data->{'warnings'}=2;
        return 0;
   }
    
    return 1;
}

sub addAuthor
{
    my ($self,$name)=@_;
    
    my $author =  Models::Performers::Authors->new();
    unless($author->add($name))
    {
        return 0;
    }

    return 1;
}


sub addGenre
{
    my ($self,$name)=@_;
    
    my $genre =  Models::Performers::Genre->new();
    unless($genre->add($name))
    {
        return 0;
    }

    return 1;
}

sub addCart
{
    my ($self)=@_;
    #$debug->setMsg('add cart');
    my $user = Models::Performers::User->new();

    my $userid=$user->getId();
    
    
    #$cart->add(7,6,6);
    unless( $in{'data'})
    {
        $data->{'warnings'}=6;
        return 0;
    }
    my $cart = Models::Performers::Cart->new();
    
    $cart->clear($userid);

    if( $in{'data'} == -1)
    {
        $debug->setMsg('clear, data='.$in{'data'});

        return 1; # need  coman clear cart   
    }

    my  $arr =  decode_json $in{'data'}; 
    

    for(@$arr)
    {
            $cart->add($userid,$_->{'id'}, $_->{'count'});
    }

    #$debug->setMsg($arr->[0]{id});
    $data->{'warnings'}=5;
    return 1;

}

sub addOrder
{

    unless($in{'payment'})
    {
        $data->{'warnings'}=6;
        return 0;
    }
    my $user = Models::Performers::User->new();
    my $userid=$user->getId();
    
    my $cart = Models::Performers::Cart->new();

    my $res = $cart->get($userid);
    $debug->setMsg('me');

    unless($res)
    {
        return 0; #cart is empry
    }
    $debug->setMsg( 'me2' );

    my $order= Models::Performers::Order->new();
    if($order->add($userid,$in{'payment'},$res,$user->getSale() ))
    {
        $data->{'warnings'}=5;
    }
     
    $debug->setMsg($in{'payment'});
    
    #####clear cart #####

    $cart->clear();

    return 1;
}


sub setLang
{
    my $lang = Models::Utilits::Lang->new();
    
    unless($in{'lang'})
    {
        $data->{'warnings'}=6;
        return 0;
    }
    $debug->setMsg('lang = '.$lang->set($in{'lang'}));
    #$lang->set($in{'lang'});
    $data->{'warnings'}=5;
    return 1;
}

1;
