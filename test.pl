#!/usr/bin/perl 

use warnings;
use strict;

use File::Basename;

use constant TDIR=>dirname(__FILE__);
use lib TDIR;
use lib TDIR.'/Models/Utilits';
#use lib TDIR.'/Downloads';
#use lib TDIR.'/Downloads/XML-SAX-0.99';
use XML::Simple qw(:strict);

Config::Config->setDir(TDIR);
#use XML::Parser;
#use XML::SAX;
 use JSON;
use Models::Performers::Cart;
use Models::Performers::Book;
use Models::Utilits::Debug;
use Data::Dumper;
use Models::Performers::Admin;
my $debug = Models::Utilits::Debug->new();
use Models::Utilits::Lang;
use Models::Utilits::File;
#use Config::Config;
use Models::Performers::Payment;
use Models::Performers::Order;

sub addbook
{
    my $book =  Models::Performers::Book->new();



    my @arrauthor=(1,2,3);
    my @arrgenre=(1,2);
    
    print Dumper @arrauthor;
    my $res=$book->add('titel',120,'myimage.jpg','info',\@arrauthor, \@arrgenre);


    if($res)
    {
        print "good\n";
    }
    else
    {
        print "no\n";
        #my $debug = Models::Utilits::Debug->new();
        #my $d=$debug->getMsg();
        #print  Dumper(\$d);

    }
}


sub getAllBooks
{
    # my $book =  Models::Performers::Book->new();
    #my $res = $book->getAll();
    
}


sub addadmin
{
    my $admin= Models::Performers::Admin->new();
    if($admin->add( 'admin','admin','admin@mail.ru'))
    {
        print 'admin add';
    }
    
}


sub getAllbooks
{
    print "Get all books:\n";
    my $book =  Models::Performers::Book->new();
    my $res=$book->getAll();
    print  Dumper $res;
    #print $res;
    print "\n";
}

sub getLang
{
    my $lang = Models::Utilits::Lang->new();
    my $ref =  $lang->get();
  
        print Dumper $ref;
    

}


sub fCart
{
    my $cart = Models::Performers::Cart->new();

    #$cart->add(7,6,6);
    #$cart->add(7,5,11);
    #$cart->add(7,8,11);
    #$cart->delete(7,5);
    my $res = $cart->get(2);
    print  Dumper $res;

}

sub Sale
{

    my $admin= Models::Performers::Admin->new();
    unless($admin->login('sasha@mail.ru','test')) 
    {
        return 0;
    }
    print $admin->setSale(3);

    print  $admin->getSale();
}


sub payment
{
    my $payment=Models::Performers::Payment->new();
    #print $payment->add('webmoney');
    #$payment->add('pay2pay');
    #$payment->add('privat24');
    my $res = $payment->get();
    print   Dumper($res);

    $res = $payment->getForId(2);
    print   Dumper($res);


}

sub order
{
    my $order= Models::Performers::Order->new();
    $order->add(2,1,0);
    
}

sub main
{

    #addadmin();
    #addbook();
    #getAllbooks();
    #getLang();
    
    #Sale();
    #fCart();
    #my $temp = '[{"id":"3","count":2},{"id":"2","count":1}]'; 
    #my $res = decode_json $temp;
    
    # print $res;
    #print   Dumper(\$res);
    #payment();
    my $d=$debug->getMsg();
        print  Dumper(\$d);

}

#select DISTINCT shop_books.id, shop_books.title ,(
#   SELECT GROUP_CONCAT( a.name ) as idauthor 
#   FROM shop_book2author b2a , shop_author a 
#   WHERE b2a.idbook = shop_books.id AND a.id = b2a.idauthor) 
#FROM shop_books ;


main();

