package Controllers::CtrlPages::Api;

use warnings;
use strict;

use Config::Config;

use Data::Dumper;
use Models::Utilits::Date;
use Models::Performers::Admin;
my $debug = Models::Utilits::Debug->new();
use JSON;

use vars qw(%in);
use Models::Utilits::Email::Valid;
use CGI qw(:cgi-lib :escapeHTML :unescapeHTML);
use Models::Performers::Cart;
use Models::Performers::Authors;
use Models::Performers::Genre;

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
    elsif($data->{'pageparam'} eq 'payment')
    {
      return 1; 
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

    else{}
    





    ################FOR ADMIN#################################

    if( $user->getRole() )
    {
        $data->{'pageparam'} = undef;
        return 0;
    }   


    if( $data->{'pageparam'} eq 'addauthor') 
    {
        $self->addAuthor($in{'name'});

    }
    elsif($data->{'pageparam'} eq 'addgenre' )
    {
        $self->addGenre($in{'name'});
    }


    ##$data->{'pageparam'}

    return 0;

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
    my  $arr =  decode_json $in{'data'}; 
    

    for(@$arr)
    {
            $cart->add($userid,$_->{'id'}, $_->{'count'});
    }

    #$debug->setMsg($arr->[0]{id});
    $data->{'warnings'}=5;
    return 1;

}

1;
